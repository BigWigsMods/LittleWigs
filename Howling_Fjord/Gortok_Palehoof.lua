----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Gortok Palehoof"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26687
mod.toggleOptions = {"roar", "impale", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Roar", 48256, 59267)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Impale", 48261, 59268)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Roar(_, spellId, _, _, spellName)
	if self.db.profile.roar then
		self:IfMessage(spellName, "Urgent", spellId)
		self:Bar(L["roarcooldown_bar"], 10, spellId)
	end
end

function mod:Impale(player, spellId, _, _, spellName)
	if self.db.profile.impale then
		self:IfMessage(L["impale_message"]:format(spellName, player), "Attention", spellId)
	end
end
