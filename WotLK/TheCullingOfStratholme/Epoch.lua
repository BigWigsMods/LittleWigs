-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Chrono-Lord Epoch", 521)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26532)
mod.toggleOptions = {
	52772, -- Curse
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 52772)
	self:Log("SPELL_AURA_REMOVED", "CurseRemove", 52772)
	self:Death("Win", 26532)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Curse(player, spellId, _, _, spellName)
	self:Message(52772, spellName..": "..player, "Important", spellId)
	self:Bar(52772, player..": "..spellName, 10, spellId)
end

function mod:CurseRemove(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
