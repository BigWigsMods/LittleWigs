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
	
	poundbar = "Pound Bar",
	poundbar_desc = "Show a cast bar while Anub'arak is casting pound.",
} end)

L:RegisterTranslations("deDE", function() return {
	pound = "Hämmern",
	pound_desc = "Warnt wenn Anub'arak Hämmern zaubert.",
	pound_message = "Zaubert Hämmern",
	
	poundbar = "Hämmern Bar",
	poundbar_desc = "Zeigt eine Bar an während Anub'arak Hämmern Zaubert.",
} end)

L:RegisterTranslations("frFR", function() return {
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	pound = "Удар",
	pound_desc = "Предупреждать о применении Ануб'араком Удара.",
	pound_message = "Применение Удара",
	
	poundbar = "Полоса Удара",
	poundbar_desc = "Отображать полосу применения, когда Ануб'арак применяет удар.",
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
mod.toggleoptions = {"pound","poundbar","bosskill"}
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
	if self.db.profile.poundbar then
		self:Bar(L["pound_message"], 3.2, spellId)
	end
	if self.db.profile.pound then
		self:IfMessage(L["pound_message"], "Attention", spellId)
	end
end
