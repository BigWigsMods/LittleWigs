-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Meathook", 521)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26529)
mod.toggleOptions = {
	52696, -- Chains
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_AURA_APPLIED", "Chains", 52696, 58823)
	self:Death("Win", 26529)
end

-------------------------------------------------------------------------------
--  Event Handlers
--
function mod:Chains(player, spellId, _, _, spellName)
	self:Message(52696, spellName..": "..player, "Important", spellId)
	self:Bar(52696, player..": "..spellName, 5, spellId)
end
