-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Infinite Corruptor", 521)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(32273)
mod.toggleOptions = {
	60588, -- Blight
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Blight", 60588)
	self:Death("Win", 32273)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Blight(player, spellId, _, _, spellName)
	self:Message(60588, spellName..": "..player, "Important", spellId)
	self:Bar(60588, player..": "..spellName, 120, spellId)
end
