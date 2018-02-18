-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Bronjahm", 601, 615)
if not mod then return end
--mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36497)

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

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 36497)
end

function mod:OnEngage()
	if self:CheckOption(68872, "MESSAGE") then -- Soulstorm is %-based
		self:RegisterEvent("UNIT_HEALTH")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(_, unit)
	if UnitName(unit) ~= self.displayName then return end
	local health = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if health > 30 and health <= 35 then
		self:UnregisterEvent("UNIT_HEALTH")
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
	self:StopBar(args.spellId, args.destName)
end
