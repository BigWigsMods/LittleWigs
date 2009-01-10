------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Trollgore"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Trollgore",

	wound = "Infected Wound",
	wound_desc = "Warn when some has an Infected Wound.",
	wound_message = "Infected Wound: %s",

	woundBar = "Infected Wound Bar",
	woundBar_desc = "Show a bar for the duration of an Infected Wound.",
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
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 26630
mod.toggleoptions = {"wound", "woundBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Wound", 49637)
	self:AddCombatListener("SPELL_AURA_REMOVED", "WoundRemoved", 49637)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Wound(player, spellId)
	if self.db.profile.wound then
		self:IfMessage(L["wound_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.woundBar then
		self:Bar(L["wound_message"], 10, spellId)
	end
end

function mod:WoundRemoved(player)
	if self.db.profile.woundBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["wound_message"]:format(player))
	end
end
