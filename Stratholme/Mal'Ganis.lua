------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mal'Ganis"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local sleepDuration

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Mal'Ganis",

	sleep = "Sleep",
	sleep_desc = "Warn for who is put to sleep.",

	sleepBar = "Sleep Bar",
	sleepBar_desc = "Show a bar for the duration of the sleep.",

	sleep_message = "Sleep: %s",

	vampTouch = "Vampiric Touch",
	vampTouch_desc = "Warn when Mal'Ganis gains Vampiric Touch.",
	vampTouch_message = "Mal'Ganis gains Vampiric Touch",
	
	vampTouchBar = "Vampiric Touch Bar",
	vampTouchBar_desc = "Display a bar for the duration of Mal'Ganis Vampiric Touch.",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26533
mod.toggleoptions = {"sleep", "sleepBar", -1, "vampTouch", "vampTouchBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Sleep", 52721, 58849)
	self:AddCombatListener("SPELL_AURA_REMOVED", "SleepRemove", 52721, 58849)	
	self:AddCombatListener("SPELL_AURA_APPLIED", "VampTouch", 52723)
	self:AddCombatListener("SPELL_AURA_REMOVED", "VampTouchRemove", 52723)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Curse(player, spellId)
	if self.db.profile.curse then
		self:IfMessage(L["curse_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.curseBar then
		if spellId == 58849 then sleepDuration = 8 else sleepDuration = 10 end
		self:Bar(L["curse_message"]:format(player), sleepDuration, spellId)
	end
end

function mod:CurseRemove(player)
	if self.db.profile.curseBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["curse_message"]:format(player))
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
