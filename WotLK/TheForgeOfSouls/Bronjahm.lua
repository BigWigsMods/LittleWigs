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
		{68839, "ICON"}, -- Corrupt Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CorruptSoul", 68839)
	self:Log("SPELL_AURA_REMOVED", "CorruptSoulRemoved", 68839)
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 35 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(68872, "red", nil, CL.soon:format(self:SpellName(68872))) -- Soulstorm
	end
end

function mod:CorruptSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alert")
	self:TargetBar(args.spellId, 4, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:CorruptSoulRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
