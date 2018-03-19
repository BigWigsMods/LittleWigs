-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Bronjahm", 632, 615)
if not mod then return end
mod:RegisterEnableMob(36497)
mod.engageId = 2006
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		68872, -- Soulstorm
		68839, -- Corrupt Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CorruptSoul", 68839)
	self:Log("SPELL_AURA_REMOVED", "CorruptSoulRemoved", 68839)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 35 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(68872, "Important", nil, CL.soon(self:SpellName(68872))) -- Soulstorm
	end
end

function mod:CorruptSoul(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert")
	self:TargetBar(args.spellId, 4, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:CorruptSoulRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
