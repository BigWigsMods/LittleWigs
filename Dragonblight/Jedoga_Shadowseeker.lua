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
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29310
mod.toggleoptions = {"thundershock","thundershockbar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Thunershock", 55931)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Thunershock(_, spellId, _, _, spellName)
	if self.db.profile.thundershock then
		self:IfMessage(spellName, "Important", spellId)
	end
	if self.db.profile.thundershockbar then
		self:Bar(spellName, 10, spellId)
	end
end
