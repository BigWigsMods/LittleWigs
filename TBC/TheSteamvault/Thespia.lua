-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Hydromancer Thespia", 727, 573)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17797)
mod.toggleOptions = {
	25033, -- Lightning Cloud
	31481, -- Lung Burst
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Storm", 25033)
	self:Log("SPELL_AURA_APPLIED", "Burst", 31481)
	self:Death("Win", 17797)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm(_, spellId, _, _, spellName)
	self:Message(25033, spellName, "Attention", spellId)
end

function mod:Burst(player, spellId, _, _, spellName)
	self:Message(31481, spellName..": "..player, "Important", spellId)
	self:Bar(31481, player..": "..spellName, 10, spellId) 
end
