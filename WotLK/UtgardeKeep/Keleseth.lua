-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Prince Keleseth", 523)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(23953)
mod.toggleOptions = {
	48400, -- Ice Tomb
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Tomb", 48400)
	self:Log("SPELL_AURA_REMOVED", "TombRemoved", 48400)
	self:Death("Win", 23953)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Tomb(player, spellId, _, _, spellName)
	self:Message(48400, spellName..": "..player, "Urgent", spellId)
	self:Bar(48400, player..": "..spellName, 20, spellId)
end

function mod:TombRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
