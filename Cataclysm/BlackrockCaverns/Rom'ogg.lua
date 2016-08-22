-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rom'ogg Bonecrusher", 753)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39665)
mod.toggleOptions = {
	75543, -- The Skullcracker
	75272, -- Quake
	75539, -- Chains
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Skullcracker", 75543, 93453)
	self:Log("SPELL_CAST_START", "Quake", 75272)
	self:Log("SPELL_CAST_START", "Chains", 75539)
	self:Death("Win", 39665)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Skullcracker(_, spellId, _, _, spellName)
	local time = self:GetInstanceDifficulty() == 2 and 8 or 12 --8sec on heroic, 12 on normal
	self:Bar(75543, spellName, time, spellId)
	self:Message(75543, LW_CL["seconds"]:format(spellName, time), "Urgent", spellId)
end

function mod:Quake(_, spellId, _, _, spellName)
	--self:Bar(75272, LW_CL["next"]:format(spellName), 19, spellId) --innacurate?
	self:Message(75272, LW_CL["casting"]:format(spellName), "Attention", spellId)
end

function mod:Chains(_, spellId, _, _, spellName)
	self:Message(75539, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
end

