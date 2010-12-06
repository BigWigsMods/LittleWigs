-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Erudax", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40484)
mod.toggleOptions = {
	75664, -- Shadow Gale
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
	self:Log("SPELL_CAST_START", "Gale", 75664)

	self:Death("Win", 40484)
	
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Gale(_, _, _, _, spellName)
	self:Bar(75664, spellName, 5, 75664)
	self:Message(75664, LCL["casting"]:format(spellName), "Urgent", 75664, "Alert")
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find(L["summon_trigger"]) then
		self:Message(summon, L["summong_message"], "Attention")
	end
end