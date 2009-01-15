------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Chrono-Lord Epoch"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Epoch",

	curse = "Curse of Exertion",
	curse_desc = "Announce the casting of Curse of Exertion",

	curseBar = "Curse of Exertion Bar",
	curseBar_desc = "Show a bar for the duration of the Curse of Exertion",

	curse_message = "Exertion: %s",

	warpBar = "Time Warp Bar",
	warpBar_desc = "Show a bar for the duration of a Time Warp.",
} end )

L:RegisterTranslations("koKR", function() return {
	curse = "노력의 저주",
	curse_desc = "노력의 저주 시전을 알립니다.",

	curseBar = "노력의 저주 바",
	curseBar_desc = "노력의 저주가 지속되는 바를 표시합니다.",

	curse_message = "노력의 저주: %s",

	warpBar = "시간 왜곡 바",
	warpBar_desc = "시간 왜곡이 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	curse = "費力詛咒",
	curse_desc = "當正在施放費力詛咒時發出警報。",

	curseBar = "費力詛咒計時條",
	curseBar_desc = "當費力詛咒持續時顯示計時條。",

	curse_message = "費力詛咒：>%s<！",

	warpBar = "時間扭曲計時條",
	warpBar_desc = "當時間扭曲持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	curse = "耗能诅咒",
	curse_desc = "当正在施放耗能诅咒时发出警报。",

	curseBar = "耗能诅咒计时条",
	curseBar_desc = "当耗能诅咒持续时显示计时条。",

	curse_message = "耗能诅咒：>%s<！",

	warpBar = "时间扭曲计时条",
	warpBar_desc = "当时间扭曲持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	curse = "Проклятье усталости",
	curse_desc = "Сообщать о применении проклятья усталости",

	curseBar = "Полоса проклятья усталости",
	curseBar_desc = "Отображать полосу продолжительности проклятья усталости",

	curse_message = "Усталость: %s",

	warpBar = "Полоса искажения времени",
	warpBar_desc = "Отображать полосу продолжительности искажения времени.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26532
mod.toggleoptions = {"curse", "curseBar", -1, "warpBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Curse", 52772)
	self:AddCombatListener("SPELL_AURA_REMOVED", "CurseRemove", 52772)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Warp", 52766)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Curse(player, spellId)
	if self.db.profile.curse then
		self:IfMessage(L["curse_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.curseBar then
		self:Bar(L["curse_message"]:format(player), 10, spellId)
	end
end

function mod:CurseRemove(player)
	if self.db.profile.curseBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["curse_message"]:format(player))
	end
end

function mod:Warp(_, spellId, _, _, spellName)
	if self.db.profile.warpBar then
		self:Bar(spellName, 6, spellId)
	end
end
