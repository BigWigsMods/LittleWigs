------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Anub'arak"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Anub'arak",

	pound = "Pound",
	pound_desc = "Warn when Anub'arak begins casting pound.",
	pound_message = "Casting Pound",

	poundBar = "Pound Bar",
	poundBar_desc = "Show a cast bar while Anub'arak is casting pound.",
} end)

L:RegisterTranslations("deDE", function() return {
	pound = "H\195\164mmern",
	pound_desc = "Warnung wenn Anub'arak H\195\164mmern zaubert.",
	pound_message = "Zaubert H\195\164mmern!",

	poundBar = "H\195\164mmern-Anzeige",
	poundBar_desc = "Eine Leiste anzeigen w\195\164hrend Anub'arak H\195\164mmern zaubert.",
} end)

L:RegisterTranslations("frFR", function() return {
	pound = "Marteler",
	pound_desc = "Prévient quand Anub'arak commence à incanter Marteler.",
	pound_message = "Marteler en incantation",

	poundBar = "Marteler - Barre",
	poundBar_desc = "Affiche une barre d'incantation pour le Marteler d'Anub'arak.",
} end)

L:RegisterTranslations("koKR", function() return {
	pound = "강타",
	pound_desc = "아눕아락의 강타 시전을 알립니다.",
	pound_message = "강타 시전",
	
	poundBar = "강타 바",
	poundBar_desc = "아눕아락의 강타 시전바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	pound = "重击",
	pound_desc = "当阿努巴拉克开始施放重击时发出警报。",
	pound_message = "正在施放 重击！",

	poundBar = "重击计时条",
	poundBar_desc = "当阿努巴拉克施放重击时显示计时条。",
} end)

L:RegisterTranslations("zhTW", function() return {
	pound = "猛擊",
	pound_desc = "當阿努巴拉克開始施放猛擊時發出警報。",
	pound_message = "正在施放 猛擊！",

	poundBar = "猛擊計時條",
	poundBar_desc = "當阿努巴拉克施放猛擊時顯示計時條。",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	pound = "Удар",
	pound_desc = "Предупреждать о применении Ануб'араком Удара.",
	pound_message = "Применение Удара",

	poundBar = "Полоса Удара",
	poundBar_desc = "Отображать полосу применения, когда Ануб'арак применяет удар.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Azjol-Nerub"]
mod.enabletrigger = boss
mod.guid = 29120
mod.toggleoptions = {"pound","poundBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Pound", 53472, 59433)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Pound(_, spellId)
	if self.db.profile.poundBar then
		self:Bar(L["pound_message"], 3.2, spellId)
	end
	if self.db.profile.pound then
		self:IfMessage(L["pound_message"], "Attention", spellId)
	end
end
