------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Volkhan"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Volkhan",

	stomp = "Shattering Stomp",
	stomp_desc = "Warn when Volkhan is going to shatter all his Brittle Golems.",
	stomp_message = "Casting Shattering Stomp",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	stomp = "Piétinement fracassant",
	stomp_desc = "Prévient quand Volkhan est sur le point de briser tous ses Golems vermoulus.",
	stomp_message = "Se prépare à briser tous les Golems vermoulus !",
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
	stomp = "Раскатистый топот",
	stomp_desc = "Предупреждать когда Volkhan собирается в разбить все его големы.",
	stomp_message = "Применяется Раскатистый топот",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28587
mod.toggleoptions = {"stomp","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Stomp", 52237, 59529)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Stomp(_, spellId, _, _, spellName)
	if self.db.profile.stomp then
		self:IfMessage(L["stomp_message"], "Urgent", spellId)
		self:Bar(spellName, 3, spellId)
	end
end
