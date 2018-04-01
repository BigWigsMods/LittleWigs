-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Krik'thir the Gatewatcher", 601, 585)
if not mod then return end
mod:RegisterEnableMob(28684)
mod.engageId = 1971
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		52592, -- Curse of Fatigue
		28747, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CurseOfFatigue", 52592, 59368) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "CurseOfFatigueRemoved", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 28747)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CurseOfFatigue(args)
	self:TargetMessage(52592, args.destName, "Attention")
	self:TargetBar(52592, 10, args.destName)
end

function mod:CurseOfFatigueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Frenzy(args)
	self:Message(args.spellId, "Important", nil, CL.percent:format(10, args.spellName))
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 10 and health <= 15 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(28747, "Important", nil, CL.soon:format(self:SpellName(28747))) -- Frenzy
	end
end
