------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Loken"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local casttime

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Loken",

	nova = "Lightning Nova",
	nova_desc = "Warn for the casting of Lightning Nova.",
	nova_message = "Casting Lightning Nova",

	novaBar = "Lightning Nova Bar",
	novaBar_desc = "Show a bar for the cast time of Lightning Nova.",
} end)

L:RegisterTranslations("deDE", function() return {
	nova = "Blitznova",
	nova_desc = "Warnt vor dem Zaubern von Blitznova.",
	nova_message = "Zaubert Blitznova",

	novaBar = "Blitznova Bar",
	novaBar_desc = "Zeige eine Bar für die Zauberzeit von Blitznova.",
} end)

L:RegisterTranslations("frFR", function() return {
	nova = "Nova de foudre",
	nova_desc = "Prévient quand la Nova de foudre est incantée.",
	nova_message = "Nova de foudre en incantation",

	novaBar = "Nova de foudre - Barre",
	novaBar_desc = "Affiche une barre indiquant la durée de l'incantation de la Nova de foudre.",
} end)

L:RegisterTranslations("koKR", function() return {
	nova = "번개 회오리",
	nova_desc = "번개 회오리 시전을 알립니다.",
	nova_message = "번개 회오리 시전",

	novaBar = "번개 회오리 바",
	novaBar_desc = "번개 회오리 시전 시간바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	nova = "闪电新星",
	nova_desc = "当施放闪电新星时发出警报。",
	nova_message = "正在施放 闪电新星！",

	novaBar = "闪电新星计时条",
	novaBar_desc = "当施放闪电新星时显示计时条。",
} end)

L:RegisterTranslations("zhTW", function() return {
	nova = "閃電新星",
	nova_desc = "當施放閃電新星時發出警報。",
	nova_message = "正在施放 閃電新星！",

	novaBar = "閃電新星計時條",
	novaBar_desc = "當施放閃電新星時顯示計時條。",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	nova = "Вспышка молнии",
	nova_desc = "Предупреждать о применении вспышки молнии.",
	nova_message = "Применяется вспышка молнии",

	novaBar = "Полоса вспышки молнии",
	novaBar_desc = "Отображать полосу применения вспышки молнии.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28586
mod.toggleoptions = {"nova","novaBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Nova", 52960, 59835)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Nova(_, spellId, _, _, spellName)
	if self.db.profile.nova then
		self:IfMessage(L["nova_message"], "Urgent", spellId)
	end
	if self.db.profile.novaBar then
		if GetInstanceDifficulty() == 1 then casttime = 5 else casttime = 4 end
		self:Bar(spellName, casttime, spellId)
	end
end
