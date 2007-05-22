------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Warlord Kalithresh"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Kalithresh",

	spell = "Spell Reflection",
	spell_desc = "Warn for Spell Reflection",
	spell_trigger = "gains Spell Reflection.$",
	spell_message = "Spell Reflection!",

	rage = "Warlord's Rage",
	rage_desc = "Warn for channeling of rage",
	rage_trigger1 = "^%s begins to channel",
	rage_trigger2 = "This is not nearly over...",
	rage_message = "Warlord is channeling!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "督軍卡利斯瑞",

	spell = "法術反射",
	spell_desc = "法術反射警報",
	spell_trigger = "獲得了法術反射的效果。$",
	spell_message = "法術反射！ 法系停火！",

	rage = "督軍之怒",
	rage_desc = "督軍之怒警報",
	rage_trigger1 = "^%s開始從附近的蒸餾器輸送……",
	rage_trigger2 = "這離結束還差的遠……",
	rage_message = "即將發動督軍之怒！ DPS 蒸餾器！",
} end )

L:RegisterTranslations("frFR", function() return {
	spell = "Renvoi de sort",
	spell_desc = "Préviens quand Kalithresh renvoye les sorts.",
	spell_trigger = "gagne Renvoi de sort.$",
	spell_message = "Renvoi de sort !",

	rage = "Rage du seigneur de guerre",
	rage_desc = "Préviens quand Kalithresh canalise de la rage.",
	rage_trigger1 = "^%s commence à canaliser", -- à vérifier
	rage_trigger2 = "This is not nearly over...", -- à traduire
	rage_message = "Canalisation en cours !",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Steamvault"]
mod.enabletrigger = boss 
mod.toggleoptions = {"spell", "rage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE", "Channel")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Channel")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if self.db.profile.spell and msg:find(L["spell_trigger"]) then
		self:Message(L["spell_message"], "Attention")
	end
end

function mod:Channel(msg)
	if not self.db.profile.rage then return end
	if msg:find(L["rage_trigger1"]) or msg == L["rage_trigger2"] then
		self:Message(L["rage_message"], "Urgent")
	end
end
