----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Constructor & Controller"]
local constructor = BB["Skarvald the Constructor"]
local controller = BB["Dalronn the Controller"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = {constructor, controller} 
mod.guid = 24200
mod.toggleOptions = {"debilitate", "debilitateBar", "bosskill"}

--------------------------------
--       Are you local?       --
--------------------------------

local deaths = 0

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "Deaths")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Debilitate", 43650)

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	deaths = 0	
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Deaths(_, guid)
	if not self.db.profile.bosskill then return end
	guid = tonumber((guid):sub(-12,-7),16)
	if guid == self.guid or guid == 24201 then
		deaths = deaths + 1
	end
	if deaths == 2 then
		self:BossDeath(nil, self.guid, true)
	end
end

function mod:Debilitate(player, spellId)
	if self.db.profile.debilitate then
		self:IfMessage(L["debilitate_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.debilitateBar then
		self:Bar(L["debilitate_message"]:format(player), 8, spellId)
	end
end
