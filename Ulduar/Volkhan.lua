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

	stompBar = "Shattering Stomp Bar",
	stompBar_desc = "Display a casting bar for Shattering Stomp.",

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
	stomp = "분쇄의 발구르기",
	stomp_desc = "볼칸 빛바랜 골렘 폭파 & 분쇄의 발구르기를 알립니다.",
	stomp_message = "분쇄의 발구르기 시전",
} end)

L:RegisterTranslations("zhCN", function() return {
	stomp = "粉碎践踏",
	stomp_desc = "当沃尔坎粉碎践踏他的脆弱的傀儡时发出警报。",
	stomp_message = "正在施放 粉碎践踏！",
} end)

L:RegisterTranslations("zhTW", function() return {
	stomp = "破碎踐踏",
	stomp_desc = "當渥克瀚破碎踐踏他的脆弱的傀儡時發出警報。",
	stomp_message = "正在施放 破碎踐踏！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	stomp = "Раскатистый топот",
	stomp_desc = "Предупреждать, когда Волхан собирается раскалоть все хладные големы.",

	stompBar = "Полоса Раскатистого топота",
	stompBar_desc = "Отображать полосу применения Раскатистого топота.",

	stomp_message = "Применяется раскатистый топот!",
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
mod.toggleoptions = {"stomp", "stompBar", "bosskill"}
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
	end
	if self.db.profile.stompBar then
		self:Bar(spellName, 3, spellId)
	end
end
