------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Elder Nadox"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "ElderNadox",

	guardian = "Ahn'kahar Guardian",
	guardian_desc = "Warn for the hatching of an Ahn'kahar Guardian.",

	broodplague = "Brood Plague",
	broodplague_desc = "Warn for who has the Brood Plague debuff",
	broodplague_message = "Brood Plague: %s",

	broodplaguebar = "Brood Plague Bar",
	broodplaguebar_desc = "Show a bar for the duration of the Brood Plague debuff.",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
} end)

L:RegisterTranslations("koKR", function() return {
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29309
mod.toggleoptions = {"guardian",-1,"broodplague","broodplaguebar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:AddCombatListener("SPELL_AURA_APPLIED", "BroodPlague", 56130, 59467)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BroodPlagueRemoved", 56130, 59467)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.guardian then
		self:IfMessage(msg, "Important")
	end
end

function mod:BroodPlague(player, spellId, _, _, spellName)
	if self.db.profile.broodplague then
		self:IfMessage(L["broodplague_message"]:format(player), "Important")
	end
	if self.db.profile.broodplaguebar then
		self:Bar(L["broodplague_message"]:format(player), 30, spellID)
	end
end

function mod:BroodPlagueRemoved(player)
	if self.db.profile.broodplaguebar then
		self:TriggerEvent("BigWigs_StopBar", self, L["broodplague_message"]:format(player))
	end
end
