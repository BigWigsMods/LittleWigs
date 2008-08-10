------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Dalliah the Doomsayer"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Dalliah",

	ww = "Whirlwind",
	ww_desc = "Warns for Dalliah's Whirlwind",
	ww_message = "Dalliah begins to Whirlwind!",

	gift = "Gift of the Doomsayer",
	gift_desc = "Warns for Dalliah's Gift of the Doomsayer debuff",
	gift_message = "%s has Gift of the Doomsayer!",
	gift_bar = "Gifted: %s",

	heal = "Healing",
	heal_desc = "Warns when Dalliah is casting a heal",
	heal_message = "Casting Heal!",
} end )

L:RegisterTranslations("koKR", function() return {
	ww = "소용돌이",
	ww_desc = "달리아의 소용돌이에 대해 알립니다.",
	ww_message = "달리아 소용돌이 시작!",

	gift = "파멸의 예언자의 선물",
	gift_desc = "달리아의 파멸의 예언자의 선물 디버프에 대해 알립니다.",
	gift_message = "%s 파멸의 예언자의 선물!",
	gift_bar = "예언자의 선물: %s",
	
	heal = "치유",
	heal_desc = "달리아의 치유 마법 시전을 알립니다.",
	heal_message = "달리아 치유 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	ww = "旋風斬",
	ww_desc = "旋風斬警報",
	ww_message = "達利亞要發動旋風斬了!",

	gift = "末日預言者的賜福",
	gift_desc = "達利亞獲得末日預言者的賜福時發出警報",
	gift_message = "末日預言者的賜福: [%s]",
	gift_bar = "<末日預言者的賜福: [%s]>",

	heal = "治療",
	heal_desc = "當達利亞施放治療發出警報",
	heal_message = "達利亞正在治療!",
} end )

L:RegisterTranslations("frFR", function() return {
	ww = "Tourbillon",
	ww_desc = "Prévient quand Dalliah fait son Tourbillon.",
	ww_message = "Dalliah gagne Tourbillon !",

	gift = "Don de l'auspice funeste",
	gift_desc = "Prévient quand quelqu'un est affecté par le Don de l'auspice funeste.",
	gift_message = "Don de l'auspice funeste sur %s !",
	gift_bar = "Don : %s",

	heal = "Soin",
	heal_desc = "Prévient quand Dalliah incante un soin.",
	heal_message = "Incante un soin !",
} end )

L:RegisterTranslations("deDE", function() return {
	ww = "Wirbelwind",
	ww_desc = "Warnt vor Dalliah's Wirbelwind",
	ww_message = "Dalliah beginnt mit Wirbelwind!",

	gift = "Gabe des Verdammnisverk\195\188nders",
	gift_desc = "Warnt vor Dalliah's 'Gabe des Verdammnisverk\195\188nders'-Debuff",
	gift_message = "%s hat Gabe des Verdammnisverk\195\188nders!",
	gift_bar = "Gabe: %s",

	heal = "Heilen",
	heal_desc = "Warnt, wenn Dalliah sich heilt",
	heal_message = "Zaubert Heilung!",
} end )

L:RegisterTranslations("zhCN", function() return {
	ww = "旋风斩",
	ww_desc = "当施放旋风斩时发出警报。",
	ww_message = "即将 旋风斩！",

	gift = "末日预言者的礼物",
	gift_desc = "当获得末日预言者的礼物时发出警报。",
	gift_message = ">%s< 受到了末日预言者的礼物！",
	gift_bar = "<礼物：%s>",
	
	heal = "治疗",
	heal_desc = "当施放治疗发出警报。",
	heal_message = "正在治疗！",
} end )

L:RegisterTranslations("ruRU", function() return {
	ww = "Вихрь",
	ww_desc = "Предупреждать о вихре Далии",
	ww_message = "Далия начинает выполнять Вихрь!",

	gift = "Дар Вестника рока",
	gift_desc = "Предупреждать о отрицательном эффекте Далии - Дара Вестника рока",
	gift_message = "%s паражон Даром Вестника рока!",
	gift_bar = "Одарован: %s",

	heal = "Исцеление",
	heal_desc = "Предупреждать когда Далия начинает читать заклинание исцеления",
	heal_message = "Чтения заклинания Исциления!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = boss 
mod.guid = 20885
mod.toggleoptions = {"ww", "gift", "heal", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Heal", 36144)
	self:AddCombatListener("SPELL_CAST_START", "WW", 36175)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Gift", 36173)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:WW()
	if self.db.profile.ww then
		self:IfMessage(L["ww_message"], "Important", 39009)
		self:Bar(L["ww"], 6, 39009)
	end
end

function mod:Heal()
	if self.db.profile.heal then
		self:IfMessage(L["heal_message"], Urgent, 39013)
	end
end

function mod:Gift(player, spellId)
	if self.db.profile.gift then
		self:IfMessage(L["gift_message"]:format(player), "Urgent", spellId)
		self:Bar(L["gift_bar"]:format(player), 10, spellId)
	end
end
