-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Erudax", "Grim Batol")
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
if L then
--@do-not-package@
L["summon"] = "Summon Faceless Guardian"
L["summon_desc"] = "Warn when Erudax summons a Faceless Guardian"
L["summong_message"] = "Faceless Guardian Summoned"
L["summon_trigger"] = "%s summons a"--@end-do-not-package@
--@localization(locale="enUS", namespace="GrimBatol/Erudax", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Gale", 75664, 91086)

	self:Death("Win", 40484)
	
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Gale(_, _, _, _, spellName)
	self:Bar(91086, spellName, 5, 91086)
	self:Message(91086, LCL["casting"]:format(spellName), "Urgent", 91086, "Alert")
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find(L["summon_trigger"]) then
		self:Message(summon, L["summong_message"], "Attention")
	end
end