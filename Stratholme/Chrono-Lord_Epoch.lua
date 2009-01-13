------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Chrono-Lord Epoch"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Epoch",

	curse = "Curse of Exertion",
	curse_desc = "Announce the casting of Curse of Exertion",

	curseBar = "Curse of Exertion Bar",
	curseBar_desc = "Show a bar for the duration of the Curse of Exertion",

	curse_message = "Exertion: %s",

	warpBar = "Time Warp Bar",
	warpBar_desc = "Show a bar for the duration of a Time Warp.",
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
mod.guid = 26532
mod.toggleoptions = {"curse", "curseBar", -1, "warpBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Curse", 52772)
	self:AddCombatListener("SPELL_AURA_REMOVED", "CurseRemove", 52772)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Warp", 52766)
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
