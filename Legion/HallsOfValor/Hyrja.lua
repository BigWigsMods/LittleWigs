--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hyrja", 1477, 1486)
if not mod then return end
mod:RegisterEnableMob(95833)
mod:SetEncounterID(1806)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local nextArcingBolt, nextExpelLight, nextSpecial = 0, 0, 0
local thunderEmpowermentStacks, holyEmpowermentStacks = 0, 0
local thunderEmpowermentFalloffTime, holyEmpowermentFalloffTime = 0, 0
local preferredSpecial = 192307 -- Sanctify
local specialCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200901, -- Eye of the Storm
		{191976, "ICON", "SAY"}, -- Arcing Bolt
		192307, -- Sanctify
		{192048, "ICON", "FLASH"}, -- Expel Light
		192018, -- Shield of Light
	}
end

function mod:OnBossEnable()
	-- cast always
	self:Log("SPELL_CAST_START", "ShieldOfLight", 192018)
	self:Log("SPELL_CAST_SUCCESS", "ArcingBolt", 191976)

	-- cast when thunder empowered
	self:Log("SPELL_CAST_START", "EyeOfTheStorm", 200901)

	-- cast when holy empowered
	self:Log("SPELL_CAST_START", "Sanctify", 192307)
	self:Log("SPELL_AURA_APPLIED", "ExpelLight", 192048)
	self:Log("SPELL_AURA_REMOVED", "ExpelLightRemoved", 192048)

	-- empowerment auras
	self:Log("SPELL_AURA_APPLIED", "EmpowermentThunderApplied", 192132) -- Mystic Empowerment: Thunder, grants Eye of the Storm
	self:Log("SPELL_AURA_APPLIED_DOSE", "EmpowermentThunderApplied", 192132)
	self:Log("SPELL_AURA_REMOVED_DOSE", "EmpowermentThunderRemoved", 192132)
	self:Log("SPELL_AURA_REMOVED", "EmpowermentThunderRemoved", 192132)
	self:Log("SPELL_AURA_APPLIED", "EmpowermentHolyApplied", 192133) -- Mystic Empowerment: Holy, grants Sanctify and Expel Light
	self:Log("SPELL_AURA_APPLIED_DOSE", "EmpowermentHolyApplied", 192133)
	self:Log("SPELL_AURA_REMOVED_DOSE", "EmpowermentHolyRemoved", 192133)
	self:Log("SPELL_AURA_REMOVED", "EmpowermentHolyRemoved", 192133)
end

function mod:OnEngage()
	local t = GetTime()
	specialCount = 0
	nextArcingBolt, nextExpelLight, nextSpecial = t + 3.6, t + 4.9, t + 8.1
	thunderEmpowermentStacks, holyEmpowermentStacks = 0, 0
	preferredSpecial = 192307 -- Sanctify
	self:Bar(191976, 3.6) -- Arcing Bolt
	self:Bar(192307, 8.1) -- Sanctify
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function recheckSpecial()
	if preferredSpecial == 192307 then -- Sanctify
		-- Sanctify will be cast unless there will be 0 Holy Empowerment stacks at the end of the timer
		if holyEmpowermentStacks >= 1 and (holyEmpowermentFalloffTime == 0 or holyEmpowermentFalloffTime > nextSpecial) then
			mod:StopBar(200901) -- Eye of the Storm
			mod:Bar(192307, {nextSpecial - GetTime(), specialCount == 0 and 8.1 or 30.4}) -- Sanctify
		else
			-- Eye of the Storm will be cast even though it was cast last
			mod:StopBar(192307) -- Sanctify
			mod:Bar(200901, {nextSpecial - GetTime(), specialCount == 0 and 8.1 or 30.4}) -- Eye of the Storm
		end
	else -- 200901, Eye of the Storm
		-- Eye of the Storm will be cast unless there will be 0 Thunder Empowerment stacks at the end of the timer
		if thunderEmpowermentStacks >= 1 and (thunderEmpowermentFalloffTime == 0 or thunderEmpowermentFalloffTime > nextSpecial) then
			mod:StopBar(192307) -- Sanctify
			mod:Bar(200901, {nextSpecial - GetTime(), specialCount == 0 and 8.1 or 30.4}) -- Eye of the Storm
		else
			-- Sanctify will be cast even though it was cast last
			mod:StopBar(200901) -- Eye of the Storm
			mod:Bar(192307, {nextSpecial - GetTime(), specialCount == 0 and 8.1 or 30.4}) -- Sanctify
		end
	end
end

local function adjustMinorCastTimers(t, castTime)
	-- adjust Arcing Bolt's and Expel Light's CD bars
	if nextArcingBolt - t < castTime then
		nextArcingBolt = t + (castTime + 0.3)
		if mod:BarTimeLeft(191976) > 0 then -- make sure there's a bar in the first place
			mod:CDBar(191976, castTime + 0.3)
		end
	end
	if nextExpelLight - t < castTime then
		nextExpelLight = t + (castTime + 3.8) -- doesn't cast it instantly after Sanctify / EotS
		if holyEmpowermentStacks >= 1 and (holyEmpowermentFalloffTime == 0 or holyEmpowermentFalloffTime > nextExpelLight) then
			mod:CDBar(192048, castTime + 3.8)
		else
			mod:StopBar(192048)
		end
	end
end

function mod:ShieldOfLight(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:ArcingBolt(args)
	if self:MobId(args.sourceGUID) ~= 95833 then
		-- no timer for trash version
		return
	end
	self:SecondaryIcon(args.spellId)
	nextArcingBolt = GetTime() + 12
	self:CDBar(args.spellId, 12)
end

function mod:EyeOfTheStorm(args)
	if self:MobId(args.sourceGUID) ~= 95833 then
		-- don't alert for trash version
		return
	end
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	preferredSpecial = 192307
	nextSpecial = t + 30.4
	specialCount = specialCount + 1
	recheckSpecial()
	self:CDBar(192018, 15.8) -- Shield of Light
	adjustMinorCastTimers(t, 13) -- cast time of Eye of the Storm
end

function mod:Sanctify(args)
	if self:MobId(args.sourceGUID) ~= 95833 then
		-- don't alert for trash version
		return
	end
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	preferredSpecial = 200901
	nextSpecial = t + 30.4
	specialCount = specialCount + 1
	recheckSpecial()
	self:CDBar(192018, 15.8) -- Shield of Light
	adjustMinorCastTimers(t, 11.5) -- cast time of Sanctify
end

function mod:ExpelLight(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	self:PrimaryIcon(args.spellId, args.destName)
	nextExpelLight = GetTime() + 20.7
	self:CDBar(args.spellId, 20.7)
end

function mod:ExpelLightRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:EmpowermentThunderApplied(args)
	thunderEmpowermentStacks = args.amount or 1
	thunderEmpowermentFalloffTime = 0
	recheckSpecial()
end

function mod:EmpowermentThunderRemoved(args)
	thunderEmpowermentStacks = args.amount or 0
	if thunderEmpowermentStacks == 0 then
		thunderEmpowermentFalloffTime = 0
	else -- if on non-Normal difficulty
		-- 2 stacks are removed per 4 seconds when not empowered
		thunderEmpowermentFalloffTime = GetTime() + ceil(thunderEmpowermentStacks / 2) * 4
	end
	recheckSpecial()
end

function mod:EmpowermentHolyApplied(args)
	holyEmpowermentStacks = args.amount or 1
	if holyEmpowermentStacks == 1 then
		local remaining = nextExpelLight - GetTime()
		self:CDBar(192048, remaining > 0.4 and remaining or 0.4) -- Expel Light
	end
	holyEmpowermentFalloffTime = 0
	recheckSpecial()
end

function mod:EmpowermentHolyRemoved(args)
	holyEmpowermentStacks = args.amount or 0
	if holyEmpowermentStacks == 0 then
		self:StopBar(192048) -- Expel Light
		holyEmpowermentFalloffTime = 0
	else -- if on non-Normal difficulty
		-- 2 stacks are removed per 4 seconds when not empowered
		holyEmpowermentFalloffTime = GetTime() + ceil(holyEmpowermentStacks / 2) * 4
	end
	recheckSpecial()
end
