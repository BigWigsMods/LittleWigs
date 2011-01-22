-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Asaad", "The Vortex Pinnacle")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43875)
mod.toggleOptions = {
	86930, -- Supremacy of the Storm
	87618, -- Static Cling
	"bosskill",
}
mod.optionHeaders = {
	[86930] = "normal",
	[87618] = "heroic",
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	-- Supremacy of the Storm is one we care about, but when he starts casting
	-- the grounding field is a good time to warn:
	self:Log("SPELL_AURA_APPLIED", "Storm", 86911)
	-- Actually scan for Chain Lightning as it comes first:
	self:Log("SPELL_CAST_START", "Cling", 93993)

	self:Death("Win", 43875)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm()
	local storm = GetSpellInfo(86930)
	self:Bar(86930, storm, 10, 86930)
	self:Message(86930, LW_CL["seconds"]:format(storm, 10), "Important", 86930)
end

function mod:Cling()
	local cling = GetSpellInfo(87618)
	self:Bar(87618, "~"..cling, 4.5, 87618)
	self:Message(87618, LW_CL["seconds"]:format(cling, 4.5), "Attention", 87618)
end