------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mal'Ganis"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local sleepDuration

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Mal'Ganis",

	sleep = "Sleep",
	sleep_desc = "Warn for who is put to sleep.",

	sleepBar = "Sleep Bar",
	sleepBar_desc = "Show a bar for the duration of the sleep.",

	sleep_message = "Sleep: %s",

	vampTouch = "Vampiric Touch",
	vampTouch_desc = "Warn when Mal'Ganis gains Vampiric Touch.",
	vampTouch_message = "Mal'Ganis gains Vampiric Touch",
	
	vampTouchBar = "Vampiric Touch Bar",
	vampTouchBar_desc = "Display a bar for the duration of Mal'Ganis Vampiric Touch.",
} end )

L:RegisterTranslations("koKR", function() return {
	sleep = "수면",
	sleep_desc = "수면에 걸린 플레이어를 알립니다.",

	sleepBar = "수면 바",
	sleepBar_desc = "수면이 지속되는 바를 표시합니다.",

	sleep_message = "수면: %s",

	vampTouch = "흡혈의 손길",
	vampTouch_desc = "말가니스의 흡혈의 손길 획득을 알립니다.",
	vampTouch_message = "말가니스 흡혈의 손길 획득",
	
	vampTouchBar = "흡혈의 손길 바",
	vampTouchBar_desc = "말가니스의 흡혈의 손길이 지속되는 바를 표시합니다.",
} end )

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

function mod:Curse(player, spellId)
	if self.db.profile.curse then
		self:IfMessage(L["curse_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.curseBar then
		if spellId == 58849 then sleepDuration = 8 else sleepDuration = 10 end
		self:Bar(L["curse_message"]:format(player), sleepDuration, spellId)
	end
end

function mod:CurseRemove(player)
	if self.db.profile.curseBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["curse_message"]:format(player))
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
