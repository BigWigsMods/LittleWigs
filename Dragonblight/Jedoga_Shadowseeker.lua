------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Jedoga Shadowseeker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Jedoga",

	thundershock = "Thundershock",
	thundershock_desc = "Warn when Jedoga Shadowseeker casts Thundershock.",

	thundershockbar = "Thundershock Bar",
	thundershockbar_desc = "Show a bar for the duration of Jedoga Shadowseeker's Thundershock.",
} end)

L:RegisterTranslations("deDE", function() return {
	thundershock = "Donnerschock",
	thundershock_desc = "Warnt wenn Jedoga Schattensucher Donnerschock zaubert.",

	thundershockbar = "Donnerschock Bar",
	thundershockbar_desc = "Zeigt eine Bar für die Dauer von Jedoga Schattensuchers Donnerschock.",
} end)

L:RegisterTranslations("frFR", function() return {
	thundershock = "Coup de tonnerre",
	thundershock_desc = "Prévient quand Jedoga incante son Coup de tonnerre.",

	thundershockbar = "Coup de tonnerre - Barre",
	thundershockbar_desc = "Affiche une barre indiquant la durée du Coup de tonnerre de Jedoga.",
} end)

L:RegisterTranslations("koKR", function() return {
	thundershock = "천둥 충격",
	thundershock_desc = "어둠 추적자 제도가의 천둥 충격 시전을 알립니다.",

	thundershockbar = "천둥 충격 바",
	thundershockbar_desc = "어둠 추적자 제도가의 천둥 충격 지속 바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	thundershock = "Громовой удар",
	thundershock_desc = "Предупреждать когда Джедога Искательница Теней начинает применение Громового удара.",

	thundershockbar = "Полоса Громового удара",
	thundershockbar_desc = "Отображать полосу продолжительности Громовых ударов Джедога.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29310
mod.toggleoptions = {"thundershock","thundershockbar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Thundershock", 56926)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Thundershock(_, spellId, _, _, spellName)
	if self.db.profile.thundershock then
		self:IfMessage(spellName, "Important", spellId)
	end
	if self.db.profile.thundershockbar then
		self:Bar(spellName, 10, spellId)
	end
end
