-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Salramm the Fleshcrafter", 521)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26530)
mod.toggleOptions = {
	58845, -- Flesh
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Flesh", 58845)
	self:Log("SPELL_AURA_REMOVED", "FleshRemoved", 58845)
	self:Death("Win", 26530)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Flesh(player, spellId, _, _, spellName)
	self:Message(58845, spellName..": "..player, "Important", spellId)
	self:Bar(58845, player..": "..spellName, 30, spellId)
end

function mod:FleshRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
