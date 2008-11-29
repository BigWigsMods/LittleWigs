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

	transformationBar = "Transformation Casting Bar",
	transformationBar_desc = "Show a casting bar for Transformation.",

	transformation_message = "Casting Transformation",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	transformation = "Преображение",
	transformation_desc = "Предупреждать когда Мураби начинает применять Преображение.",

	transformationBar = "Полоса Преображения",
	transformationBar_desc = "Отображать полосу применения Преображения.",

	transformation_message = "Применияется Преображение!",
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
