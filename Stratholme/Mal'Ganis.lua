------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mal'Ganis"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local sleepDuration

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	sleep = "催眠術",
	sleep_desc = "當玩家中了催眠術時發出警報。",

	sleepBar = "催眠術計時條",
	sleepBar_desc = "當催眠術持續時顯示計時條。",

	sleep_message = "催眠術：>%s<！",

	vampTouch = "吸血之觸",
	vampTouch_desc = "當瑪爾加尼斯獲得吸血之觸時發出警報。",
	vampTouch_message = "瑪爾加尼斯獲得：>吸血之觸<！",
	
	vampTouchBar = "吸血之觸計時條",
	vampTouchBar_desc = "當瑪爾加尼斯的吸血之觸持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	sleep = "Schlaf",
	sleep_desc = "Warnung wer von Schlaf betroffen ist.",
	
	sleepBar = "Schlaf-Anzeie",
	sleepBar_desc = "Eine Leiste f\195\188r die Dauer von Schlaf anzeigen.",

	sleep_message = "Schlaf: %s",

	vampTouch = "Vampirber\195\188hrung",
	vampTouch_desc = "Warnung wenn Mal'Ganis die Vampirber\195\188hrung erh\195\164lt.",
	vampTouch_message = "Mal'Ganis erh\195\164lt Vampirber\195\188hrung!",
 
	vampTouchBar = "Vampirber\195\188hrung-Anzeige",
	vampTouchBar_desc = "Eine Leiste f\195\188r die Dauer von Vampirber\195\188hrung anzeigen.",	
} end )

L:RegisterTranslations("zhCN", function() return {
	sleep = "沉睡",
	sleep_desc = "当玩家中了沉睡时发出警报。",

	sleepBar = "沉睡计时条",
	sleepBar_desc = "当沉睡持续时显示计时条。",

	sleep_message = "沉睡：>%s<！",

	vampTouch = "吸血鬼之触",
	vampTouch_desc = "当玛尔加尼斯获得吸血鬼之触时发出警报。",
	vampTouch_message = "玛尔加尼斯获得：>吸血鬼之触<！",
	
	vampTouchBar = "吸血鬼之触计时条",
	vampTouchBar_desc = "当玛尔加尼斯的吸血鬼之触持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	sleep = "Сон",
	sleep_desc = "Сообщать о том кто усыплен.",

	sleepBar = "Полоса сна",
	sleepBar_desc = "Отображать полосу продолжительности сна.",

	sleep_message = "Усыплен: %s",

	vampTouch = "Прикосновение вампира",
	vampTouch_desc = "Сообщать когда Мал'Ганис получает Прикосновение вампира.",
	vampTouch_message = "Мал'Ганис получил Прикосновение вампира!",
	
	vampTouchBar = "Полоса прикосновения вампира",
	vampTouchBar_desc = "Отображать полосу продолжительности прикосновения вампира Мал'Ганиса.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26533
mod.toggleoptions = {"sleep", "sleepBar", -1, "vampTouch", "vampTouchBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Sleep", 52721, 58849)
	self:AddCombatListener("SPELL_AURA_REMOVED", "SleepRemove", 52721, 58849)	
	self:AddCombatListener("SPELL_AURA_APPLIED", "VampTouch", 52723)
	self:AddCombatListener("SPELL_AURA_REMOVED", "VampTouchRemove", 52723)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Sleep(player, spellId)
	if self.db.profile.sleep then
		self:IfMessage(L["sleep_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.sleepBar then
		if spellId == 58849 then sleepDuration = 8 else sleepDuration = 10 end
		self:Bar(L["sleep_message"]:format(player), sleepDuration, spellId)
	end
end

function mod:SleepRemove(player)
	if self.db.profile.sleepBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["sleep_message"]:format(player))
	end
end

function mod:VampTouch(target, spellId, _, _, spellName)
	if target ~= boss then return end
	if self.db.profile.vampTouch then
		self:IfMessage(L["vampTouch_message"], "Important", spellId)
	end
	if self.db.profile.vampTouchBar then
		self:Bar(spellName, 30, spellId)
	end
end

function mod:VampTouchRemove(target, _, _, _, spellName)
	if target ~= boss then return end
	if self.db.profile.vampTouchBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end
