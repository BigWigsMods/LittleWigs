-- XXX Ulic: Only thing useful I could think of is a timer for when the tornados
-- XXX Ulic: collapse, assuming is consistant, need more logs to find out

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Vizier Ertan", "The Vortex Pinnacle")
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

function mod:Summon(unit, spellId, _, _, spellName)
	self:Bar(86340, LCL["next"]:format(spellName, 19), spellId)
	self:Message(86340, spellName, "Alert", spellId)
end
