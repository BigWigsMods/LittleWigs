------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Herald Volazj"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Volazj",

	insanity = "Insanity",
	insanity_desc = "Warn when Herald Volazj begins to cast Insanity.",
	insanity_message = "Casting Insanity",
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
mod.guid = 29311
mod.toggleoptions = {"insantiy","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Insanity", 57496)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Insanity(_, spellId)
	if self.db.profile.insanity then
		self:IfMessage(L["insanity_message"], "Important", spellId)
	end
end
