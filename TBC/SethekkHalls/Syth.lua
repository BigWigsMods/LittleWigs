-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Darkweaver Syth", 556, 541)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18472)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.summon = "Summon Elementals"
	L.summon_desc = "Warn for Summoned Elementals"
	L.summon_message = "Elementals Summoned!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"summon", -- Focus Fire
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "Summon", 33538)
	self:Death("Win", 18472)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Summon()
	self:Message("summon", "Attention", nil, L.summon_message)
end
