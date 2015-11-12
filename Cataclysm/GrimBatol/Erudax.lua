-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Erudax", 757)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40484)
mod.toggleOptions = {
	91086, -- Shadow Gale
	"summon",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then--@do-not-package@
L["summon"] = "Summon Faceless Guardian"
L["summon_desc"] = "Warn when Erudax summons a Faceless Guardian"
L["summon_message"] = "Faceless Guardian Summoned"
L["summon_trigger"] = "%s summons a"--@end-do-not-package@
--@localization(locale="enUS", namespace="GrimBatol/Erudax", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Gale", 75664, 91086)
	self:Emote("Summon", L["summon_trigger"])

	self:Death("Win", 40484)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Gale(_, spellId, _, _, spellName)
	self:Bar(91086, spellName, 5, spellId)
	self:Message(91086, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alert")
end

function mod:Summon()
	self:Message("summon", L["summon_message"], "Important")
end

