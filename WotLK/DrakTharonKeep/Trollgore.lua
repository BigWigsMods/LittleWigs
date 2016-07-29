-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Trollgore", 534)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26630)
mod.toggleOptions = {
	49637, -- Wound
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Wound", 49637)
	self:Log("SPELL_AURA_REMOVED", "WoundRemoved", 49637)
	self:Death("Win", 26630)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Wound(player, spellId, _, _, spellName)
	self:Message(49637, spellName..": "..player, "Urgent", spellId)
	self:Bar(49637, player..": "..spellName, 10, spellId)
end

function mod:WoundRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
