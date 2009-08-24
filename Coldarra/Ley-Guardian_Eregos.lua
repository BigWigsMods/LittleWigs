------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ley-Guardian Eregos"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Ley_Guardian_Eregos", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27656
mod.toggleOptions = {"planarshift", "planarshiftbar", -1, "enragedassault", "enragedassaultbar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "PlanarShift", 51162)
	self:AddCombatListener("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PlanarShift(_, spellId, _, _, spellName)
	if self.db.profile.planarshift then
		self:IfMessage(L["planarshift_message"], "Important", spellId)
		self:DelayedMessage(13, L["planarshift_expire_message"], "Attention")
	end
	if self.db.profile.planarshiftbar then
		self:Bar(spellName, 18, spellId)
	end
end

function mod:EnragedAssault(player, spellId, _, _, spellName)
	if self.db.profile.enragedassault then
		self:IfMessage(L["enragedassault_message"], "Important", spellId)
	end
	if self.db.profile.enragedassaultbar then
		self:Bar(spellName, 12, spellId)
	end
end
