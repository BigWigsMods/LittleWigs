-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Krik'thir the Gatewatcher", 533, 585)
if not mod then return end
--mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(28684)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		52592, -- Curse of Fatigue
		28747, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigue", 52592, 59368)
	self:Log("SPELL_AURA_REMOVED", "CurseOfFatigueRemoved", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 28747)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:Death("Win", 28684)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CurseOfFatigue(args)
	self:TargetMessage(52592, args.destName, "Attention")
	self:TargetBar(52592, 10, args.destName)
end

function mod:CurseOfFatigueRemoved(args)
	self:StopBar(52592, args.destName)
end

function mod:Frenzy(args)
	self:Message(args.spellId, "Important", nil, CL.onboss:format(args.spellName))
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 10 and health <= 15 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(28747, "Important", nil, CL.soon(self:SpellName(28747))) -- Frenzy
	end
end
