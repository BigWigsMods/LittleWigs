----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Erekem"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29315
mod.toggleOptions = {"earthshield", "chainheal", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dalaran/Erekem", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "EarthShield", 54479, 59471)
	self:AddCombatListener("SPELL_CAST_START", "ChainHeal", 54481, 59473)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:EarthShield(_, spellId)
	if self.db.profile.earthshield then
		self:IfMessage(L["earthshield_message"], "Important", spellId)
	end
end

function mod:ChainHeal(_, spellId, _, _, spellName)
	if self.db.profile.chainheal then
		self:IfMessage(L["chainheal_message"], "Urgent", spellId)
	end
end

