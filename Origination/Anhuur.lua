-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Temple Guardian Anhuur", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39425)
mod.toggleOptions = {74938, {75592, "ICON", "FLASHSHAKE"}, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shield", 74938)
	self:Log("SPELL_AURA_APPLIED", "Reckoning", 75592, 94949)
	self:Death("Win", 39425)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shield(_, _, _, _, spellName)
	self:Message(74938, spellName, "Urgent", 74938)
	self:Bar(74938, spellName, 10, 74938)
end

function mod:Reckoning(player, _, _, _, spellName)
	self:TargetMessage(75592, spellName, player, "Urgent", 75592, "Alert")
	self:Bar(75592, player..": "..spellName, 8, 75592)
	self:PrimaryIcon(75592, player)
	if UnitIsUnit(player, "player") then self:FlashShake(75592) end
end

