--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yazma", 1763, 2030)
if not mod then return end
mod:RegisterEnableMob(122968) -- Yazma
mod:SetEncounterID(2087)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local soulrendCount = 1
local nextEchoesOfShadra = 0
local nextWrackingPain = 0
local nextSkewer = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259187, -- Soulrend
		250050, -- Echoes of Shadra
		250036, -- Shadowy Remains
		{250096, "ME_ONLY_EMPHASIZE"}, -- Wracking Pain
		{249919, "TANK_HEALER"}, -- Skewer
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "Soulrend", 259187)
	self:Log("SPELL_CAST_START", "EchoesofShadra", 250050)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowyRemains", 250036) -- don't track APPLIED - doesn't damage on application
	self:Log("SPELL_PERIODIC_MISSED", "ShadowyRemains", 250036)
	self:Log("SPELL_CAST_START", "WrackingPain", 250096)
	self:Log("SPELL_CAST_START", "Skewer", 249919)
end

function mod:OnEngage()
	soulrendCount = 1
	local t = GetTime()
	self:CDBar(250096, 3.3) -- Wracking Pain
	nextWrackingPain = t + 3.3
	self:CDBar(249919, 5.1) -- Skewer
	nextSkewer = t + 5.1
	self:CDBar(259187, 9.7, CL.count:format(self:SpellName(259187), soulrendCount)) -- Soulrend
	self:CDBar(250050, 15.4) -- Echoes of Shadra
	nextEchoesOfShadra = t + 15.4
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
		if spellId == 259186 then -- Soulrend
			-- use this event instead of SPELL_CAST_START for timer adjustments. if the tank is the only
			-- one alive Yazma will still attempt to cast Soulrend with this spell ID and the other spells
			-- will be delayed even in the absense of the usual SPELL_CAST_START for Soulrend.
			local t = GetTime()
			prev = t
			self:StopBar(CL.count:format(self:SpellName(259187), soulrendCount))
			soulrendCount = soulrendCount + 1
			self:CDBar(259187, 41.2, CL.count:format(self:SpellName(259187), soulrendCount))
			-- 6.04 minimum to Echoes of Shadra or Skewer
			if nextEchoesOfShadra - t < 6.04 then
				nextEchoesOfShadra = t + 6.04
				self:CDBar(250050, {6.04, 31.5}) -- Echoes of Shadra
			end
			if nextSkewer - t < 6.04 then
				nextSkewer = t + 6.04
				self:CDBar(249919, {6.04, 12.1}) -- Skewer
			end
		end
	end

	function mod:Soulrend(args)
		-- correct the count for the message, decrement if this event occurs after 259186
		local soulrendMessageCount = GetTime() - prev > 3 and soulrendCount or soulrendCount - 1
		self:Message(args.spellId, "red", CL.count:format(args.spellName, soulrendMessageCount))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:EchoesofShadra(args)
	local t = GetTime()
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 31.5)
	nextEchoesOfShadra = t + 31.5
	-- 3.62 minimum to Wracking Pain or Skewer
	if nextWrackingPain - t < 3.62 then
		nextWrackingPain = t + 3.62
		self:CDBar(250096, {3.62, 17.0}) -- Wracking Pain
	end
	if nextSkewer - t < 3.62 then
		nextSkewer = t + 3.62
		self:CDBar(249919, {3.62, 12.1}) -- Skewer
	end
end

do
	local prev = 0
	function mod:ShadowyRemains(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(250096, "orange", name)
			self:PlaySound(250096, "alert", nil, name)
		end
	end

	function mod:WrackingPain(args)
		local t = GetTime()
		if self:MythicPlus() then
			-- not interruptible in Mythic+, get target instead
			self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		else -- Normal, Heroic, Mythic
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:CDBar(args.spellId, 17.0)
		nextWrackingPain = t + 17.0
	end
end

function mod:Skewer(args)
	local t = GetTime()
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "alarm")
	else
		self:PlaySound(args.spellId, "alert")
	end
	-- 3.62 minimum to Echoes of Shadra or Wracking Pain
	self:CDBar(args.spellId, 12.1)
	nextSkewer = t + 12.1
	if nextEchoesOfShadra - t < 3.62 then
		nextEchoesOfShadra = t + 3.62
		self:CDBar(250050, {3.62, 31.5}) -- Echoes of Shadra
	end
	if nextWrackingPain - t < 3.62 then
		nextWrackingPain = t + 3.62
		self:CDBar(250096, {3.62, 17.0}) -- Wracking Pain
	end
end
