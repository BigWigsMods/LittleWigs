------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Moragg"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Moragg",

	opticlink = "Optic Link",
	opticlink_desc = "Warn when someone has Optic Link.",

	opticlinkBar = "Optic Link Bar",
	opticlinkBar_desc = "Display a bar for the duration of Optic Link.",

	opticlink_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	opticlink = "눈의 고리",
	opticlink_desc = "눈의 고리에 걸린 플레이어를 알립니다.",

	opticlinkBar = "눈의 고리 바",
	opticlinkBar_desc = "눈의 고리의 지속되는 바를 표시합니다.",

	opticlink_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	opticlink = "Lien optique",
	opticlink_desc = "Prévient quand un joueur subit les effets du Lien optique.",

	opticlinkBar = "Lien optique - Barre",
	opticlinkBar_desc = "Affiche une barre indiquant la durée du Lien optique.",

	opticlink_message = "%s : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29316
mod.toggleoptions = {"opticlink", "opticlinkBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "OpticLink", 54396)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:OpticLink(player, spellId, _, _, spellName)
	if self.db.profile.opticlink then
		self:IfMessage(L["opticlink_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.opticlinkBar then
		self:Bar(L["opticlink_message"]:format(spellName, player), 12, spellId)
	end
end
