-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Temple Guardian Anhuur", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39425)
mod.toggleOptions = {74938, {75592, "ICON", "FLASHSHAKE"}, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shield", 74938)
	self:Log("SPELL_AURA_APPLIED", "Reckoning", 75592, 94949)
	self:Log("SPELL_AURA_REMOVED", "ReckoningRemoved", 75592, 94949)
	self:Death("Win", 39425)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shield(_, spellId, _, _, spellName)
	self:Message(74938, spellName, "Important", spellId, "Long")
end

function mod:Reckoning(player, spellId, _, _, spellName)
	self:TargetMessage(75592, spellName, player, "Attention", spellId, "Alert")
	self:Bar(75592, spellName..": "..player, 8, spellId)
	self:PrimaryIcon(75592, player)
	if UnitIsUnit(player, "player") then
		self:FlashShake(75592)
	end
end

function mod:ReckoningRemoved(player, _, _, _, spellName)
	self:PrimaryIcon(75592)
	self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
end

