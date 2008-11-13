------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Loken"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

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
} end)

L:RegisterTranslations("frFR", function() return {
	nova = "Nova de foudre",
	nova_desc = "Prévient quand la Nova de foudre est incantée.",
	nova_message = "Nova de foudre en incantation",

	novaBar = "Nova de foudre - Barre",
	novaBar_desc = "Affiche une barre indiquant la durée de l'incantation de la Nova de foudre.",
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
		self:Bar(spellName, 5, spellId)
	end
end
