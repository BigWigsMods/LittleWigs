----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Prince Keleseth"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = boss 
mod.guid = 23953
mod.toggleOptions = {"tomb", "tombBar", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/Prince_Keleseth", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Tomb", 48400)
	self:AddCombatListener("SPELL_AURA_REMOVED", "TombRemoved", 48400)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Tomb(player, spellId)
	if self.db.profile.tomb then
		self:IfMessage(L["tomb_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.tombBar then
		self:Bar(L["tomb_message"]:format(player), 20, spellId)
	end
end

function mod:TombRemoved(player)
	if self.db.profile.tombBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["tomb_message"]:format(player))
	end
end
