-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Vizier Ertan", 769)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43878)
mod.toggleOptions = {
	86340, --Summon Tempest
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Summon", 86340)

	self:Death("Win", 43878)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Summon(_, spellId, _, _, spellName)
	self:Bar(86340, LW_CL["next"]:format(spellName), 19, spellId)
	self:Message(86340, spellName, "Attention", spellId)
end

