-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple Guardian Anhuur", 644, 124)
if not mod then return end
mod:RegisterEnableMob(39425)
mod.engageId = 1080
mod.respawnTime = 30

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
		{75592, "FLASH", "SAY", "SAY_COUNTDOWN", "PROXIMITY", "ICON"}, -- Divine Reckoning
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
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
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
		self:OpenProximity(args.spellId, 7)
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 8)
	else
		self:OpenProximity(args.spellId, 7, args.destName)
	end
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:DivineReckoningRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:CloseProximity(args.spellId)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
