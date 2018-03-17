
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Violence", 959, 685)
if not mod then return end
mod:RegisterEnableMob(56719)
mod.engageId = 1305
mod.respawnTime = 29

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5813, -- Enrage
		106872, -- Disorienting Smash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Enrage", 38166)
	self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 38166)
	self:Log("SPELL_AURA_APPLIED", "Smash", 106872)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "EnrageSoon", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Smash(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", 34618) -- 34618 = Smash
	self:TargetBar(args.spellId, 4, args.destName, 34618)
	self:CDBar(args.spellId, 17, 34618) -- 17-19
end

function mod:Enrage(args)
	self:Message(-5813, "Important", "Long", args.spellId)
	self:Bar(-5813, 30, args.spellId)
end

function mod:EnrageRemoved(args)
	self:StopBar(args.spellName)
end

function mod:EnrageSoon(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 25 then
		self:Message(-5813, "Positive", "Info", CL.soon:format(self:SpellName(38166)), false) -- Enrage
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
	end
end
