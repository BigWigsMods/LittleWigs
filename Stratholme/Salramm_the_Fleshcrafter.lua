----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Salramm the Fleshcrafter"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26530
mod.toggleoptions = {"flesh", "fleshBar", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Stratholme/Salramm_the_Fleshcrafter", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Flesh", 58845)
	self:AddCombatListener("SPELL_AURA_REMOVED", "FleshRemoved", 58845)
	self:AddCombatListener("SPELL_CAST_START", "Ghouls", 52451)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Ghouls(_, spellId)
	if self.db.profile.ghouls then
		self:IfMessage(L["ghouls_message"], "Important", spellId)
	end
end

function mod:Flesh(player, spellId)
	if self.db.profile.flesh then
		self:IfMessage(L["flesh_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.fleshBar then
		self:Bar(L["flesh_message"]:format(player), 30, spellId)
	end
end

function mod:FleshRemoved(player)
	if self.db.profile.fleshBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["flesh_message"]:format(player))
	end
end
