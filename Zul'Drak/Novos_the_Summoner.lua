------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Novos the Summoner"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Novos",

	misery = "Wrath of Misery",
	misery_desc = "Warn what party memeber has the Wrath of Misery curse.",
	misery_message = "Wrath of Misery: %s",
	
	miseryBar = "Wrath of Misery Bar",
	miseryBar_desc = "Show a bar for the duration of the Wrath of Misery curse.",
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
mod.guid = 26631
mod.toggleoptions = {"misery", "miseryBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Misery", 50089, 59856)
	self:AddCombatListener("SPELL_AURA_REMOVED", "MiseryRemoved", 50089, 59856)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Misery(player, spellId, _, _, spellName)
	if self.db.profile.misery then
		self:IfMessage(L["misery_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.miseryBar then
		self:Bar(L["misery_message"]:format(player), 6, spellId)
	end
end

function mod:MiseryRemoved(player)
	if self.db.profile.miseryBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["misery_message"]:format(player))
	end
end
