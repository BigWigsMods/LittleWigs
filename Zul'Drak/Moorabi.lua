------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Moorabi"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Moorabi",

	transformation = "Transformation",
	transformation_desc = "Warn when Moorabi begins to cast Transformation",
	transformation_message = "Casting Transformation",

	transformationBar = "Transformation Casting Bar",
	transformationBar_desc = "Show a casting bar for Transformation.",
} end )

L:RegisterTranslations("koKR", function() return {
	transformation = "변신",
	transformation_desc = "무라비의 변신을 알립니다.",
	transformation_message = "변신 시전!",

	transformationBar = "변신 시전 바",
	transformationBar_desc = "변신 시전 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	transformation = "Transformation",
	transformation_desc = "Prévient quand Moorabi commence à incanter sa Transformation.",
	transformation_message = "Transformation en incantation",

	transformationBar = "Transformation - Barre",
	transformationBar_desc = "Affiche une barre indiquant le temps d'incantation de la Transformation.",
} end )

L:RegisterTranslations("zhTW", function() return {
	transformation = "變形",
	transformation_desc = "當慕拉比開始施放變形時發出警報。",
	transformation_message = "正在施放 變形！",

	transformationBar = "施放變形計時條",
	transformationBar_desc = "當正在施放變形時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	transformation = "Transformation",
	transformation_desc = "Warnung wenn Moorabi mit dem Wirken der Transformation beginnt.",
	transformation_message = "Wirkt Transformation!",

	transformationBar = "Transformation-Zauberleiste",
	transformationBar_desc = "Eine Zauberleiste f\195\188r die Transformation anzeigen.",
} end)

L:RegisterTranslations("zhCN", function() return {
	transformation = "变形",
	transformation_desc = "当莫拉比正在施放变形时发出警报。",
	transformation_message = "正在施放 变形！",

	transformationBar = "施放变形计时条",
	transformationBar_desc = "当正在施放变形时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	transformation = "Преображение",
	transformation_desc = "Предупреждать когда Мураби начинает применять Преображение.",
	transformation_message = "Применияется Преображение!",

	transformationBar = "Полоса Преображения",
	transformationBar_desc = "Отображать полосу применения Преображения.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29305
mod.toggleoptions = {"transformation", "transformationBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Transform", 55098)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Transform(_, spellId, _, _, spellName)
	if self.db.profile.transformation then
		self:IfMessage(L["transformation_message"], "Urgent", spellId)
	end
	if self.db.profile.transformationBar then
		self:Bar(spellName, 4, spellId)
	end
end
