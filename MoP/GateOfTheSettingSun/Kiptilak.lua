
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Saboteur Kip'tilak", 962, 655)
if not mod then return end
mod:RegisterEnableMob(56906)
mod.engageId = 1397
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Locals
--

local nextExplosionWarning = 75

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{107268, "SAY", "ICON"}, -- Sabotage
		-5394, -- World in Flames
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Sabotage", 107268)
	self:Log("SPELL_AURA_REMOVED", "SabotageRemoved", 107268)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	nextExplosionWarning = 75 -- casts it at 70% and 30%
	self:CDBar(107268, 15.7) -- Sabotage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Sabotage(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm", nil, nil, true)
	self:TargetBar(args.spellId, 5, args.destName)
	self:CDBar(args.spellId, 13.4)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:SabotageRemoved(args)
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(args.spellId)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextExplosionWarning then
		self:Message(-5394, "Attention", nil, CL.soon:format(self:SpellName(-5394)))
		nextExplosionWarning = nextExplosionWarning - 40
		if nextExplosionWarning < 30 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end
