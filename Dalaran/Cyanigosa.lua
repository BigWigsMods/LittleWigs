-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Cyanigosa", "The Violet Hold")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(31134)
mod.toggleOptions = {
	58693, -- Blizzard
	59374, -- Destruction
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Blizzard", 58693, 59369)
	self:Log("SPELL_AURA_APPLIED", "Destruction", 59374)
	self:Log("SPELL_AURA_REMOVED", "DestructionRemoved", 59374)
	self:Death("Win", 31134)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Blizzard(_, spellId, _, _, spellName)
	self:Message(58693, spellName, "Attention", spellId)
end

function mod:Destruction(player, spellId, _, _, spellName)
	self:Message(58693, spellName..": "..player, "Important", spellId)
	self:Bar(58693, player..": "..spellName, 8, spellId)
end

function mod:DestructionRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
