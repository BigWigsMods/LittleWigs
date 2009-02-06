------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mage-Lord Urom"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Mage_Lord_Urom", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27655
mod.toggleoptions = {"timeBomb","timeBombWhisper","timeBombBar",-1,"arcaneExplosion","arcaneExplosionBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "TimeBomb", 51121, 59376)
	self:AddCombatListener("SPELL_CAST_START", "ArcaneExplosion", 51110, 59377)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:TimeBomb(player, spellId, _, _, spellName)
	if self.db.profile.timeBomb then
		self:IfMessage(L["timeBomb_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.timeBombWhisper and (pName ~= player) then
		self:Whisper(player, L["timeBombWhisper_message"])
	end
	if self.db.profile.timeBombBar then
		self:Bar(L["timeBomb_message"]:format(player), 6, spellId)
	end
end

function mod:ArcaneExplosion(_, spellId, _, _, spellName)
	if self.db.profile.arcaneExplosion then
		self:IfMessage(L["arcaneExplosion"], "Attention", spellId)
	end
	if self.db.profile.arcaneExplosionBar then
		self:Bar(spellName, 8, spellId)
	end
end
