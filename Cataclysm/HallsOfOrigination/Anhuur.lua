-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple Guardian Anhuur", 644, 124)
if not mod then return end
mod:RegisterEnableMob(39425)
mod:SetEncounterID(1080)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local nextShieldOfLightWarning = 0

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		74938, -- Shield of Light
		{75592, "FLASH", "SAY", "SAY_COUNTDOWN", "ICON"}, -- Divine Reckoning
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "ShieldOfLight", 74938)

	self:Log("SPELL_AURA_APPLIED", "DivineReckoning", 75592)
	self:Log("SPELL_AURA_REMOVED", "DivineReckoningRemoved", 75592)
end

function mod:OnEngage()
	nextShieldOfLightWarning = 71 -- 66% and 33%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextShieldOfLightWarning then
		self:MessageOld(74938, "yellow", nil, CL.soon:format(self:SpellName(74938))) -- Shield of Light
		nextShieldOfLightWarning = nextShieldOfLightWarning - 33
		if nextShieldOfLightWarning < 33 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:ShieldOfLight(args)
	self:MessageOld(args.spellId, "red", "long")
end

function mod:DivineReckoning(args)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId, nil, nil, "Divine Reckoning")
		self:SayCountdown(args.spellId, 8)
	end
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:DivineReckoningRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
