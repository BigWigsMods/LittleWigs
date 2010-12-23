-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Asaad", "The Vortex Pinnacle")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43875)
mod.toggleOptions = {
	86930, -- Supremacy of the Storm
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	-- Supremacy of the Storm is one we care about, but when he starts casting
	-- the grounding field is a good time to warn
	self:Log("SPELL_AURA_APPLIED", "Storm", 86911)

	self:Death("Win", 43875)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm()
	local storm = GetSpellInfo(86930)
	self:Bar(86930, storm, 10, 86930)
	self:Message(86930, LW_CL["seconds"]:format(storm, 10), "Urgent", 86930)
end

