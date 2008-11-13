------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Krystallus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Krystallus",

	engage_trigger = "Crush....",

	shatter = "Shatter",
	shatter_desc = "Warn for Ground Slam and Shatter.",
	shatter_warn = "Ground Slam - Shatter in ~8 sec!",
	shatter_message = "Shatter!",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Écraser…",

	shatter = "Fracasser",
	shatter_desc = "Prévient de l'arrivée du Heurt terreste et du Fracasser qui s'en suit.",
	shatter_warn = "Heurt terrestre - Fracasser dans ~8 sec !",
	shatter_message = "Fracasser !",
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27977
mod.toggleoptions = {"shatter", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Slam", 50833)
	self:AddCombatListener("SPELL_CAST_START", "Shatter", 50810, 61546)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Slam(_, spellId, _, _, spellName)
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_warn"], "Urgent", spellId)
		self:Bar(L["shatter_message"], 8, spellId)
	end
end

function mod:Shatter(_, spellId)
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_message"], "Urgent", spellId)
	end
end
