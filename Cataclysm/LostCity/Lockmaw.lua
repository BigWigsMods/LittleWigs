-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lockmaw", 747)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43614)
mod.toggleOptions = {
	90004,
	{89998, "ICON", "FLASHSHAKE"},
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Poison", 90004)
	self:Log("SPELL_AURA_REMOVED", "PoisonRemoved", 90004)
	self:Log("SPELL_AURA_APPLIED", "Scent", 89998)

	self:Death("Win", 43614)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Poison(player, spellId, _, _, spellName)
	self:TargetMessage(90004, spellName, player, "Attention", spellId)
	self:Bar(90004, spellName..": "..player, 12, spellId)
end

function mod:PoisonRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
end

function mod:Scent(player, spellId, _, _, spellName)
	self:TargetMessage(89998, spellName, player, "Important", spellId, "Alert")
	self:Bar(89998, spellName..": "..player, 30, spellId)
	self:PrimaryIcon(89998, player)
	if UnitIsUnit(player, "player") then
		self:FlashShake(89998)
	end
end

