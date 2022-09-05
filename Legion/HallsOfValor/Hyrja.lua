
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hyrja", 1477, 1486)
if not mod then return end
mod:RegisterEnableMob(95833)
--mod.engageId = 1806 -- Fires when you attack the 2 mobs prior to the boss...

--------------------------------------------------------------------------------
-- Locals
--

local nextArcingBolt, nextExpelLight = 0, 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200901, -- Eye of the Storm
		{191976, "ICON", "SAY"}, -- Arcing Bolt
		192307, -- Sanctify
		{192048, "ICON", "FLASH", "PROXIMITY"}, -- Expel Light
		192018, -- Shield of Light
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "EyeOfTheStormOrSanctify", 200901, 192307) -- Eye of the Storm, Sanctify
	self:Log("SPELL_CAST_START", "ShieldOfLight", 192018)

	self:Log("SPELL_CAST_START", "ArcingBolt", 191976)
	self:Log("SPELL_CAST_SUCCESS", "ArcingBoltSuccess", 191976)

	self:Log("SPELL_AURA_APPLIED", "ExpelLight", 192048)
	self:Log("SPELL_AURA_REMOVED", "ExpelLightRemoved", 192048)

	self:Log("SPELL_AURA_APPLIED", "EmpowermentThunder", 192132) -- Mystic Empowerment: Thunder, grants Arcing Bolt
	self:Log("SPELL_AURA_REMOVED", "EmpowermentThunderRemoved", 192132)
	self:Log("SPELL_AURA_APPLIED", "EmpowermentHoly", 192133) -- Mystic Empowerment: Holy, grants Expel Light
	self:Log("SPELL_AURA_REMOVED", "EmpowermentHolyRemoved", 192133)

	self:Death("Win", 95833)
end

function mod:OnEngage()
	local t = GetTime()
	nextArcingBolt, nextExpelLight = t + 4.8, t + 4.5
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShieldOfLight(args)
	self:MessageOld(args.spellId, "red", "alert")
end

function mod:EyeOfTheStormOrSanctify(args)
	self:MessageOld(args.spellId, "orange", "long")
	self:CDBar(192018, 15.8) -- 192018 = Shield of Light. Yes, I checked both EotS and Sanctify.

	-- adjust Arcing Bolt's and Expel Light's CD bars
	local t = GetTime()
	local castTime = args.spellId == 200901 and 13 or 11.5
	if nextArcingBolt - t < castTime then
		nextArcingBolt = t + (castTime + 0.3)
		if self:BarTimeLeft(191976) > 0 then -- make sure there's a bar in the first place (EmpowermentThunderRemoved calls StopBar)
			self:CDBar(191976, castTime + 0.3)
		end
	end
	if nextExpelLight - t < castTime then
		nextExpelLight = t + (castTime + 3.8) -- doesn't cast it instantly after Sanctify / EotS
		if self:BarTimeLeft(192048) > 0 then -- make sure there's a bar in the first place (EmpowermentHolyRemoved calls StopBar)
			self:CDBar(192048, castTime + 3.8)
		end
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessageOld(191976, player, "yellow", "alarm", nil, nil, true)
		self:SecondaryIcon(191976, player)
		if self:Me(guid) then
			self:Say(191976)
		end
	end

	function mod:ArcingBolt(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end

	function mod:ArcingBoltSuccess(args)
		self:SecondaryIcon(args.spellId)
		nextArcingBolt = GetTime() + 12
		self:CDBar(args.spellId, 12)
	end
end

function mod:ExpelLight(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
	self:TargetBar(args.spellId, 3, args.destName)
	if self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 8)
		self:Flash(args.spellId)
	else
		self:OpenProximity(args.spellId, 8, args.destName)
	end
	self:PrimaryIcon(args.spellId, args.destName)
	nextExpelLight = GetTime() + 20.7
	self:CDBar(args.spellId, 20.7)
end

function mod:ExpelLightRemoved(args)
	self:CloseProximity(args.spellId)
	self:PrimaryIcon(args.spellId)
end

function mod:EmpowermentThunder()
	local remaining = nextArcingBolt - GetTime()
	self:CDBar(191976, remaining > 1 and remaining or 1) -- Arcing Bolt
end

function mod:EmpowermentThunderRemoved()
	self:StopBar(191976) -- Arcing Bolt
end

function mod:EmpowermentHoly()
	local remaining = nextExpelLight - GetTime()
	self:CDBar(192048, remaining > 0.4 and remaining or 0.4) -- Expel Light
end

function mod:EmpowermentHolyRemoved()
	self:StopBar(192048) -- Expel Light
end
