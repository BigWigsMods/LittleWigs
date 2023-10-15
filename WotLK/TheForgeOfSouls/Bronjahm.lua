-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bronjahm", 632, 615)
if not mod then return end
mod:RegisterEnableMob(36497)
mod:SetEncounterID(mod:Classic() and 829 or 2006)
mod:SetRespawnTime(30)

-------------------------------------------------------------------------------
-- Initialization
--

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
-- Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 36497 then return end
	local hp = self:GetHealth(unit)
	if hp < 35 then
		self:UnregisterUnitEvent(event, unit)
		self:Message(68872, "red", CL.soon:format(self:SpellName(68872))) -- Soulstorm
	end
end

function mod:CorruptSoul(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:TargetBar(args.spellId, 4, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:CorruptSoulRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
