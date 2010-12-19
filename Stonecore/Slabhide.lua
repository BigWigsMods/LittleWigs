
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Slabhide", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43214)
mod.toggleOptions = {
	92265, --Crystal Storm
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Storm", 92265)
	self:Log("SPELL_AURA_APPLIED", "StormBegun", 92265)

	self:Death("Win", 43214)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm(_, spellId, _, _, spellName)
	self:Message(92265, LW_CL["seconds"]:format(spellName, 2.5), "Attention", spellId)
	self:Bar(92265, LW_CL["next"]:format(spellName), 2.5, spellId)
end

function mod:StormBegun(_, spellId, _, _, spellName)
	self:Bar(92265, spellName, 6, spellId)
end

