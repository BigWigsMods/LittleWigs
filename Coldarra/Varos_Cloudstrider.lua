------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Varos Cloudstrider"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Varos_Cloudstrider", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27447
mod.toggleOptions = {"amplifyMagic", "amplifyMagicBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "AmplifyMagic", 51054, 59371)
	self:AddCombatListener("SPELL_AURA_REMOVED", "AmplifyMagicRemoved", 51054, 59371)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AmplifyMagic(player, spellId, _, _, spellName)
	if self.db.profile.amplifyMagic then
		self:IfMessage(L["amplifyMagic_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.amplifyMagicBar then
		self:Bar(L["amplifyMagic_message"]:format(spellName, player), 30, spellId)
	end
end

function mod:AmplifyMagicRemoved(player, _, _, _, spellName)
	if self.db.profile.amplifyMagicBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["amplifyMagic_message"]:format(spellName, player))
	end
end
