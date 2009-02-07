----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Hadronox"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Azjol-Nerub"]
mod.enabletrigger = boss
mod.guid = 28921
mod.toggleoptions = {"leechpoison", "acidcloud", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dragonblight/Hadronox", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	-- Handles both Leech Poison and Acid Cloud
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Spell", 53400, 59419, 53030, 59417)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Spell(_, spellId, _, _, spellName)
	if self.db.profile.acidcloud or self.db.profile.leechpoison then
		self:IfMessage(spellName, "Attention", spellId)
	end
end
