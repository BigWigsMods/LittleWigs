-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rom'ogg Bonecrusher", "Blackrock Caverns")
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
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

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
	local time = 12
	if self:GetInstanceDifficulty() == 1 then
		time = 10
	end
	self:Bar(75543, spellName, time, spellId)
	self:Message(75543, LCL["seconds"]:format(spellName), "Attention", spellId)
end

function mod:Quake(_, spellId, _, _, spellName)
	self:Bar(75272, LCL["next"]:format(spellName), 19, spellId)
	self:Message(75272, LCL["casting"]:format(spellName), "Alert", spellId)
end

function mod:Chains(_, spellId, _, _, spellName)
	self:Message(75539, LCL["casting"]:format(spellName), "Info", spellId)
end