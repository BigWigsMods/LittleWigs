----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Elder Nadox"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29309
mod.toggleOptions = {"guardian",-1,"broodplague","broodplaguebar","bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dragonblight/Elder_Nadox", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:AddCombatListener("SPELL_AURA_APPLIED", "BroodPlague", 56130, 59467)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BroodPlagueRemoved", 56130, 59467)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

----------------------------------
--        Event Handlers        --
----------------------------------


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.guardian then
		self:IfMessage(msg, "Important")
	end
end

function mod:BroodPlague(player, spellId, _, _, spellName)
	if self.db.profile.broodplague then
		self:IfMessage(L["broodplague_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.broodplaguebar then
		self:Bar(L["broodplague_message"]:format(player), 30, spellId)
	end
end

function mod:BroodPlagueRemoved(player)
	if self.db.profile.broodplaguebar then
		self:TriggerEvent("BigWigs_StopBar", self, L["broodplague_message"]:format(player))
	end
end
