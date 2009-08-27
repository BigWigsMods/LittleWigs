----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Gal'darah"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29306
mod.toggleOptions = {"forms", "bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local formannounce = false

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Zul_Drak/Gal_darah", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	formannounce = false
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.forms then return end
	if UnitName(arg1) ~= boss then return end
	
	local currentHealth = UnitHealth(arg1)
	local maxHealth = UnitHealthMax(arg1)
	local percentHealth = (currentHealth/maxHealth)*100
	if not formannounce and (self:between(percentHealth, 75, 78) or self:between(percentHealth, 25, 28)) then
		self:IfMessage(L["form_rhino"], "Attention")
		formannounce = true
	elseif not formannounce and self:between(percentHealth, 50, 53) then
		self:IfMessage(L["form_troll"], "Attention")
		formannounce = true
	elseif formannounce and (self:between(percentHealth, 54, 74) or self:between(percentHealth, 29, 49)) then
		formannounce = false
	end
end

function mod:between(value, low, high)
	if (value >= low) and (value <= high) then
		return true
	end
end
