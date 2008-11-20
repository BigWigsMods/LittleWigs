------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Hadronox"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Hadronox",

	leechpoison = "Leech Poison",
	leechpoison_desc = "Warn when Hadronox casts Leech Poison.",

	acidcloud = "Acid Cloud",
	acidcloud_desc = "Warn when Hadronox casts Acid Cloud.",
} end)

L:RegisterTranslations("deDE", function() return {
	leechpoison = "Egelgift",
	leechpoison_desc = "Warnt wenn Hadronox Egelgift Zaubert.",

	acidcloud = "Säurewolke",
	acidcloud_desc = "Warnt wenn Hadronox Säurewolke Zaubert.",
} end)

L:RegisterTranslations("frFR", function() return {
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
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Azjol-Nerub"]
mod.enabletrigger = boss
mod.guid = 28921
mod.toggleoptions = {"leechpoison", "acidcloud", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- Handles both Leech Poison and Acid Cloud
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Spell", 53400, 59419, 53030, 59417)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Spell(_, spellId, _, _, spellName)
	if self.db.profile.acidcloud or self.db.profile.leechpoison then
		self:IfMessage(spellName, "Attention", spellId)
	end
end
