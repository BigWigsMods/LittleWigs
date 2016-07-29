-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Keli'dan the Breaker", 725, 557)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17377)
mod.toggleOptions = {
	30940,
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Nova", 30940)
	self:Death("Win", 17377)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Nova(_, spellId, _, _, spellName)
	self:Message(30940, spellName, "Important", spellId)
	self:Bar(30940, spellName, 5, spellId)
end
