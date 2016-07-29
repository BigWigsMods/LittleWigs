-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Hadronox", 533)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(28921)
mod.defaultToggles = {"MESSAGE"}
mod.toggleOptions = {
	53400, -- Acid Cloud
	53030, -- Poison Leech
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Acid", 53400, 59419)
	self:Log("SPELL_CAST_SUCCESS", "Leech", 53030, 59417)
	self:Death("Win", 28921)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Acid(_, spellId, _, _, spellName)
	self:Message(53400, spellName, "Attention", spellId)
end

function mod:Leech(_, spellId, _, _, spellName)
	self:Message(53030, spellName, "Attention", spellId)
end
