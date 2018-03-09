-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Moragg", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29316, 32235)
mod.toggleOptions = {
	54396, -- Optic Link
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "OpticLink", 54396)
	self:Death("Win", 29316, 32235)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:OpticLink(player, spellId, _, _, spellName)
	self:Message(54396, spellName..": "..player, "Important", spellId)
	self:Bar(54396, player..": "..spellName, 12, spellId)
end
