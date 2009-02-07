----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Novos the Summoner"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 26631
mod.toggleoptions = {"misery", "miseryBar", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Zul_Drak/Novos_the_Summoner", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Misery", 50089, 59856)
	self:AddCombatListener("SPELL_AURA_REMOVED", "MiseryRemoved", 50089, 59856)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Misery(player, spellId, _, _, spellName)
	if self.db.profile.misery then
		self:IfMessage(L["misery_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.miseryBar then
		self:Bar(L["misery_message"]:format(player), 6, spellId)
	end
end

function mod:MiseryRemoved(player)
	if self.db.profile.miseryBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["misery_message"]:format(player))
	end
end
