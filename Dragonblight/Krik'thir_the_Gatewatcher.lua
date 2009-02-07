----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Krik'thir the Gatewatcher"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Azjol-Nerub"]
mod.enabletrigger = boss
mod.guid = 28684
mod.toggleoptions = {"curse", "curseBar", -1, "frenzy", "bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local frenzyannounced = nil

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )


L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dragonblight/Krik_thir_the_Gatewatcher", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Curse", 52592, 59368)
	self:AddCombatListener("SPELL_AURA_APPLIED", "CurseRemoved", 52592, 59368)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Frenzy", 28747)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	frenzyannounced = nil
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Curse(player, spellId)
	if self.db.profile.curse then
		self:IfMessage(L["curse_message"]:format(player), "Attention", spellId)
	end
	if self.db.profile.curseBar then
		self:Bar(L["curse_message"]:format(player), 10, spellId)
	end
end

function mod:CurseRemoved(player)
	if self.db.profile.curseBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["curse_message"]:format(player))
	end
end

function mod:Frenzy(_, spellId)
	if self.db.profile.frenzy then
		self:IfMessage(L["frenzy_message"], "Important", spellId)
	end
end

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.frenzy then return end
	if UnitName(arg1) == boss then
		local currentHealth = UnitHealth(arg1)
		local maxHealth = UnitHealthMax(arg1)
		local percentHealth = (currentHealth/maxHealth)*100		
		if percentHealth > 10 and percentHealth <= 15 and not frenzyannounced then
			frenzyannounced = true
			self:IfMessage(L["frenzysoon_message"], "Important", 28747)
		elseif percentHealth > 15 and frenzyannounced then
			frenzyannounced = nil
		end
	end
end
