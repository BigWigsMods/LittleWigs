------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Prince Keleseth"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Keleseth",

	tomb = "Frost Tomb",
	tomb_desc = "Warn for who is in the Frost Tomb.",
	tomb_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	tomb = "서리 무덤",
	tomb_desc = "서리 무덤의 대상자를 알립니다.",
	tomb_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	tomb = "Tombeau de givre",
	tomb_desc = "Prévient quand un joueur subit les effets du Tombeau de givre.",
	tomb_message = "%s : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	tomb = "Ледяная могила",
	tomb_desc = "Предупреждать, когда кто-нибудь попадает в ледяную могилу.",
	tomb_message = "%s: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = boss 
mod.guid = 23953
mod.toggleoptions = {"tomb", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Tomb", 48400) --just logic speculation on the spellID
	self:AddCombatListener("SPELL_AURA_REMOVED", "TombRemoved", 48400)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Tomb(player, spellID, _, _, spellName)
	if self.db.profile.tomb then
		self:IfMessage(L["tomb_message"]:format(player, spellName), "Urgent", spellID)
		self:Bar(L["tomb_message"]:format(player, spellName), 20, spellID)
	end
end

function mod:TombRemoved(player, _, _, _, spellName)
	if self.db.profile.tomb then
		self:TriggerEvent("BigWigs_StopBar", self, L["tomb_message"]:format(player, spellName))
	end
end
