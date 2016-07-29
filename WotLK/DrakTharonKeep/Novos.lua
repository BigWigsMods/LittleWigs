-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Novos the Summoner", 534)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26631)
mod.toggleOptions = {
	50089, -- Misery
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Misery", 50089, 59856)
	self:Log("SPELL_AURA_REMOVED", "MiseryRemoved", 50089, 59856)
	self:Death("Win", 26631)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Misery(player, spellId, _, _, spellName)
	self:Message(50089, spellName..": "..player, "Urgent", spellId)
	self:Bar(50089, player..": "..spellName, 6, spellId)
end

function mod:MiseryRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
