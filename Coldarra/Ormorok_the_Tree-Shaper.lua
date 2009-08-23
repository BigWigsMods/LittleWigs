------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ormorok the Tree-Shaper"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Coldarra/Ormorok_the_Tree_Shaper", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26794
mod.toggleOptions = {"spikes", "reflection", "reflectionBar", "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Reflection", 47981)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ReflectionRemoved", 47981)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Spikes", 47958, 57082, 57083)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Frenzy", 48017, 57086)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Spikes(_, spellId, _, _, spellName)
	if self.db.profile.spikes then
		self:IfMessage(spellName, "Attention", spellId)
	end
end

function mod:Reflection(_, spellId, _, _, spellName)
	if self.db.profile.reflection then
		self:IfMessage(spellName, "Attention", spellId)
	end
	if self.db.profile.reflectionBar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ReflectionRemoved(_, _, _, _, spellName)
	if self.db.profile.reflectionBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Frenzy(_, spellId)
	if self.db.profile.frenzy then
		self:IfMessage(L["frenzy_message"], "Important", spellId)
	end
end

