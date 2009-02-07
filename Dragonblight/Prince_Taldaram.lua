----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Prince Taldaram"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29308
mod.toggleoptions = {"embraceGain","embraceFade","embraceBar",-1,"sphere","bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dragonblight/Prince_Taldaram", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Embrace", 55959, 59513)
	self:AddCombatListener("SPELL_AURA_REMOVED", "EmbraceRemoved", 55959, 59513)
	self:AddCombatListener("SPELL_CAST_START", "Sphere", 55931)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Embrace(_, spellId, _, _, spellName)
	if self.db.profile.embraceGain then
		self:IfMessage(L["embraceGain_message"], "Important", spellId)
	end
	if self.db.profile.embraceBar then
		self:Bar(spellName, 20, spellId)
	end
end

function mod:EmbraceRemoved(_, spellId, _, _, spellName)
	if self.db.profile.embraceFade then
		self:IfMessage(L["embraceFade_message"], "Positive", spellId)
	end
	if self.db.profile.embraceBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Sphere(_, spellId)
	if self.db.profile.sphere then
		self:IfMessage(L["sphere_message"], "Important", spellId)
	end
end
