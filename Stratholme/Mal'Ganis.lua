----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Mal'Ganis"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26533
mod.toggleOptions = {"sleep", "sleepBar", -1, "vampTouch", "vampTouchBar", "bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local sleepDuration

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Stratholme/Mal_Ganis", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Sleep", 52721, 58849)
	self:AddCombatListener("SPELL_AURA_REMOVED", "SleepRemove", 52721, 58849)	
	self:AddCombatListener("SPELL_AURA_APPLIED", "VampTouch", 52723)
	self:AddCombatListener("SPELL_AURA_REMOVED", "VampTouchRemove", 52723)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Sleep(player, spellId)
	if self.db.profile.sleep then
		self:IfMessage(L["sleep_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.sleepBar then
		if spellId == 58849 then sleepDuration = 8 else sleepDuration = 10 end
		self:Bar(L["sleep_message"]:format(player), sleepDuration, spellId)
	end
end

function mod:SleepRemove(player)
	if self.db.profile.sleepBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["sleep_message"]:format(player))
	end
end

function mod:VampTouch(target, spellId, _, _, spellName)
	if target ~= boss then return end
	if self.db.profile.vampTouch then
		self:IfMessage(L["vampTouch_message"], "Important", spellId)
	end
	if self.db.profile.vampTouchBar then
		self:Bar(spellName, 30, spellId)
	end
end

function mod:VampTouchRemove(target, _, _, _, spellName)
	if target ~= boss then return end
	if self.db.profile.vampTouchBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L["death_trigger"]) then
		self:BossDeath(nil, self.guid)
	end
end
