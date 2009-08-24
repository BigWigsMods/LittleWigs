----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Chrono-Lord Epoch"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26532
mod.toggleOptions = {"curse", "curseBar", -1, "warpBar", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Stratholme/Chrono_Lord_Epoch", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Curse", 52772)
	self:AddCombatListener("SPELL_AURA_REMOVED", "CurseRemove", 52772)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Warp", 52766)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Curse(player, spellId)
	if self.db.profile.curse then
		self:IfMessage(L["curse_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.curseBar then
		self:Bar(L["curse_message"]:format(player), 10, spellId)
	end
end

function mod:CurseRemove(player)
	if self.db.profile.curseBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["curse_message"]:format(player))
	end
end

function mod:Warp(_, spellId, _, _, spellName)
	if self.db.profile.warpBar then
		self:Bar(spellName, 6, spellId)
	end
end
