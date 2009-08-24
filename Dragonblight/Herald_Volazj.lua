----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Herald Volazj"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29311
mod.toggleOptions = {"insanity",-1,"shiver","shiverBar","bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dragonblight/Herald_Volazj", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Insanity", 57496)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shiver", 57949, 59978)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShiverRemoved", 57949, 59978)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Insanity(_, spellId)
	if self.db.profile.insanity then
		self:IfMessage(L["insanity_message"], "Important", spellId)
	end
end

function mod:Shiver(player, spellId, _, _, spellName)
	if self.db.profile.shiver then
		self:IfMessage(L["shiver_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.shiverBar then
		self:Bar(L["shiver_message"]:format(player), 15, spellId)
	end
end

function mod:ShiverRemoved(player)
	if self.db.profile.shiverBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["shiver_message"]:format(player))
	end
end

