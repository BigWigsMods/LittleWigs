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

	thundershockBar = "Thundershock Bar",
	thundershockBar_desc = "Show a bar for the duration of Jedoga Shadowseeker's Thundershock.",
} end)

L:RegisterTranslations("deDE", function() return {
	thundershock = "Donnerschock",
	thundershock_desc = "Warnt wenn Jedoga Schattensucher Donnerschock zaubert.",

	thundershockBar = "Donnerschock Bar",
	thundershockBar_desc = "Zeigt eine Bar für die Dauer von Jedoga Schattensuchers Donnerschock.",
} end)

L:RegisterTranslations("frFR", function() return {
	thundershock = "Coup de tonnerre",
	thundershock_desc = "Prévient quand Jedoga Cherchelombre incante son Coup de tonnerre.",

	thundershockBar = "Coup de tonnerre - Barre",
	thundershockBar_desc = "Affiche une barre indiquant la durée du Coup de tonnerre de Jedoga Cherchelombre.",
} end)

L:RegisterTranslations("koKR", function() return {
	thundershock = "천둥 충격",
	thundershock_desc = "어둠 추적자 제도가의 천둥 충격 시전을 알립니다.",

	thundershockBar = "천둥 충격 바",
	thundershockBar_desc = "어둠 추적자 제도가의 천둥 충격 지속 바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	thundershock = "雷霆震击",
	thundershock_desc = "当耶戈达·觅影者施放雷霆震击时发出警报。",

	thundershockBar = "雷霆震击计时条",
	thundershockBar_desc = "当耶戈达·觅影者的雷霆震击持续时显示计时条。",
} end)

L:RegisterTranslations("zhTW", function() return {
	thundershock = "雷霆震擊",
	thundershock_desc = "當潔杜佳·尋影者施放雷霆震擊時發出警報。",

	thundershockBar = "雷霆震擊計時條",
	thundershockBar_desc = "當潔杜佳·尋影者的雷霆震擊持續時顯示計時條。",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	thundershock = "Громовой удар",
	thundershock_desc = "Предупреждать когда Джедога Искательница Теней начинает применение Громового удара.",

	thundershockBar = "Полоса Громового удара",
	thundershockBar_desc = "Отображать полосу продолжительности Громовых ударов Джедога.",
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
mod.toggleoptions = {"thundershock","thundershockBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Thundershock", 56926, 60029)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Thundershock(_, spellId, _, _, spellName)
	if self.db.profile.thundershock then
		self:IfMessage(spellName, "Important", spellId)
	end
	if self.db.profile.thundershockBar then
		self:Bar(spellName, 10, spellId)
	end
end
