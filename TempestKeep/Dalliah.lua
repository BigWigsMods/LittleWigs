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
	ww_trigger1 = "I'll cut you to pieces!", --Yell 1
	ww_trigger2 = "Reap the whirlwind!", --Yell 2
	ww_trigger3 = "Dalliah the Doomsayer gains Whirlwind.", --she doesn't yell everytime so watch this too
	ww_message = "Dalliah begins to Whirlwind!",

	gift = "Gift of the Doomsayer",
	gift_desc = "Warns for Dalliah's Gift of the Doomsayer debuff",
	gift_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	gift_message = "%s has Gift of the Doomsayer!",
	gift_bar = "Gifted: %s",

	heal = "Healing",
	heal_desc = "Warns when Dalliah is casting a heal",
	heal_trigger = "Dalliah the Doomsayer begins to cast Heal.",
	heal_message = "Casting Heal!",
} end )

L:RegisterTranslations("koKR", function() return {
	ww = "소용돌이",
	ww_desc = "달리아의 소용돌이에 대해 알립니다.",
	ww_trigger1 = "산산조각 내 버리겠어!", --Yell 1
	ww_trigger2 = "소용돌이를 받아라!", --Yell 2
	ww_trigger3 = "파멸의 예언자 달리아|1이;가; 소용돌이 효과를 얻었습니다.", --she doesn't yell everytime so watch this too
	ww_message = "달리아 소용돌이 시작!",

	gift = "파멸의 예언자의 선물",
	gift_desc = "달리아의 파멸의 예언자의 선물 디버프에 대해 알립니다.",
	gift_trigger = "^([^|;%s]*)(.*)파멸의 예언자의 선물에 걸렸습니다.",
	gift_message = "%s 파멸의 예언자의 선물!",
	gift_bar = "예언자의 선물: %s",
	
	heal = "치유",
	heal_desc = "달리아의 치유 마법 시전을 알립니다.",
	heal_trigger = "파멸의 예언자 달리아|1이;가; 치유 시전을 시작합니다.",
	heal_message = "달리아 치유 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	ww = "旋風斬",
	ww_desc = "旋風斬警報",
	ww_trigger1 = "我將把你碎屍萬段!",
	ww_trigger2 = "遭受旋風的報應!",
	ww_trigger3 = "末日預言者達利亞獲得了旋風斬的效果。", --she doesn't yell everytime so watch this too
	ww_message = "達利亞要發動旋風斬了!",

	gift = "末日預言者的賜福",
	gift_desc = "達利亞獲得末日預言者的賜福時發出警報",
	gift_trigger = "^(.+)受(到[了]*)末日預言者的賜福效果的影響。",
	gift_message = "末日預言者的賜福: [%s]",
	gift_bar = "<末日預言者的賜福: [%s]>",

	heal = "治療",
	heal_desc = "當達利亞施放治療發出警報",
	heal_trigger = "末日預言者達利亞開始施放治療術。",
	heal_message = "達利亞正在治療!",
} end )

L:RegisterTranslations("frFR", function() return {
	ww = "Tourbillon",
	ww_desc = "Prévient quand Dalliah fait son Tourbillon.",
	ww_trigger1 = "Je vais vous découper en petits morceaux !",
	ww_trigger2 = "Récoltez la tempête !",
	ww_trigger3 = "Dalliah l'Auspice-funeste gagne Tourbillon.",
	ww_message = "Dalliah gagne Tourbillon !",

	gift = "Don de l'auspice funeste",
	gift_desc = "Prévient quand quelqu'un est affecté par le Don de l'auspice funeste.",
	gift_trigger = "^([^%s]+) ([^%s]+) les effets [de|2]+ Don de l'auspice funeste.",
	gift_message = "Don de l'auspice funeste sur %s !",
	gift_bar = "Don : %s",

	heal = "Soin",
	heal_desc = "Prévient quand Dalliah incante un soin.",
	heal_trigger = "Dalliah l'Auspice-funeste commence à lancer Soin.",
	heal_message = "Incante un soin !",
} end )

L:RegisterTranslations("deDE", function() return {
	ww = "Wirbelwind",
	ww_desc = "Warnt vor Dalliah's Wirbelwind",
	ww_trigger1 = "Ich werde Euch in St\195\188cke schneiden!", -- Yell 1
	ww_trigger2 = "Erntet den Sturm!", -- Yell 2
	ww_trigger3 = "Dalliah die Verdammnisverk\195\188nderin bekommt 'Wirbelwind'.", --she doesn't yell everytime so watch this too
	ww_message = "Dalliah beginnt mit Wirbelwind!",

	gift = "Gabe des Verdammnisverk\195\188nders",
	gift_desc = "Warnt vor Dalliah's 'Gabe des Verdammnisverk\195\188nders'-Debuff",
	gift_trigger = "^([^%s]+) ([^%s]+) von Gabe des Verdammnisverk\195\188nders betroffen.",
	gift_message = "%s hat Gabe des Verdammnisverk\195\188nders!",
	gift_bar = "Gabe: %s",

	heal = "Heilen",
	heal_desc = "Warnt, wenn Dalliah sich heilt",
	heal_trigger = "Dalliah die Verdammnisverk\195\188nderin beginnt Heilen zu wirken.",
	heal_message = "Zaubert Heilung!",
} end )

L:RegisterTranslations("zhCN", function() return {
	ww = "旋风斩",
	ww_desc = "当施放旋风斩时发出警报。",
	ww_trigger1 = "我要把你们削成碎片！",
	ww_trigger2 = "旋风斩！", 
	ww_trigger3 = "末日预言者达尔莉安获得了旋风斩的效果。",
	ww_message = "即将 旋风斩！",

	gift = "末日预言者的礼物",
	gift_desc = "当获得末日预言者的礼物时发出警报。",
	gift_trigger = "^([^%s]+)受([^%s]+)了末日预言者的礼物效果的影响。$",
	gift_message = ">%s< 受到了末日预言者的礼物！",
	gift_bar = "<礼物：%s>",
	
	heal = "治疗",
	heal_desc = "当施放治疗发出警报。",
	heal_trigger = "末日预言者达尔莉安开始施放治疗术。",
	heal_message = "正在治疗！",
} end )

L:RegisterTranslations("ruRU", function() return {
	ww = "Вихрь",
	ww_desc = "Предупреждать о вихре Далии",
	ww_trigger1 = "I'll cut you to pieces!", --Yell 1
	ww_trigger2 = "Reap the whirlwind!", --Yell 2
	ww_trigger3 = "Dalliah the Doomsayer gains Whirlwind.", --she doesn't yell everytime so watch this too
	ww_message = "Далия начинает выполнять Вихрь!",

	gift = "Дар Вестника рока",
	gift_desc = "Предупреждать о отрицательном эффекте Далии - Дара Вестника рока",
	gift_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	gift_message = "%s паражон Даром Вестника рока!",
	gift_bar = "Одарован: %s",

	heal = "Исцеление",
	heal_desc = "Предупреждать когда Далия начинает читать заклинание исцеления",
	heal_trigger = "Dalliah the Doomsayer begins to cast Heal.",
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
	self:AddCombatListener("SPELL_CAST_START", "Heal", 39013)
	self:AddCombatListener("SPELL_CAST_START", "WW", 36142)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Gift", 39009)
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
