------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Grandmaster Vorpil"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Vorpil",

	teleport = "Teleport Alert",
	teleport_desc = "Warn for Teleport",
	teleport_trigger = "gains Draw Shadows.",
	teleport_message = "Teleport!",
	teleport_warning = "Teleport in ~5sec!",
	teleport_bar = "Teleport",
	
	engage_trigger = "I'll make an offering of your blood",
} end )

L:RegisterTranslations("koKR", function() return {


} end )

L:RegisterTranslations("frFR", function() return {
	teleport = "Téléportation",
	teleport_desc = "Préviens quand Vorpil se téléporte avec le groupe.",
	teleport_trigger = "gagne Attirer les ombres.",
	teleport_message = "Téléportation !",
	teleport_warning = "Téléportation dans ~5 sec. !",
	teleport_bar = "Téléportation",

	engage_trigger = "Je ferai une offrande de ton sang", -- à vérifier
} end )

L:RegisterTranslations("zhTW", function() return {
	teleport = "傳送",
	teleport_desc = "領導者瓦皮歐施放傳送時發出警報",
	teleport_trigger = "獲得了抽取暗影的效果。",
	teleport_message = "傳送！ 迅速離開平台！",
	teleport_warning = "5 秒後傳送！",
	teleport_bar = "傳送",
	
	engage_trigger = "很好，一次值得的犧牲!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"teleport", "bosskill"}
mod.revision = tonumber(("$Revision: 33724 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.teleport and msg:find(L["engage_trigger"]) then
			self:Bar(L["teleport_bar"], 45, "Spell_Magic_LesserInvisibilty")
			self:DelayedMessage(40, L["teleport_warning"], "Attention")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if self.db.profile.teleport and msg:find(L["teleport_trigger"]) then
		self:Message(L["teleport_message"], "Urgent", nil, "Alert")
		self:Bar(L["teleport_bar"], 37, "Spell_Magic_LesserInvisibilty")
		self:DelayedMessage(32, L["teleport_warning"], "Attention")
	end
end