------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Keristrasza"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Keristrasza", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26723
mod.toggleoptions = {"chains", "chainsbar", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Enrage", 8599)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Chains", 50997)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ChainsRemoved", 50997)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chains(player, spellId, _, _, spellName)
	if self.db.profile.chains then
		self:IfMessage(L["chains_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.chainsbar then
		self:Bar(L["chains_message"]:format(spellName, player), 10, spellId)
	end
end

function mod:ChainsRemoved(player, _, _, _, spellName)
	if self.db.profile.chainsbar then
		self:TriggerEvent("BigWigs_StopBar", self, L["chains_message"]:format(spellName, player))
	end
end

function mod:Enrage(_, spellId)
	if self.db.profile.enrage then
		self:IfMessage(L["enrage_message"], "Important", spellId)
	end
end

