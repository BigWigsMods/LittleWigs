------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["High Botanist Freywinn"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Freywinn",

	tranq = "Tranquility",
	tranq_desc = "Warn for Tranquility",
	tranq_trigger = "Nature bends to my will....",
	tranq_warning = "Tranquility cast!",
	tranqfade_warning = "Tranquility fading in ~5s!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "大植物學家費瑞衛恩",

	tranq = "寧靜",
	tranq_desc = "費瑞衛恩施放寧靜時發出警報",
	tranq_trigger = "Nature bends to my will....",
	tranq_warning = "費瑞衛恩施放寧靜了！",
	tranqfade_warning = "5 秒後寧靜消散！ DPS！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Botanica"]
mod.enabletrigger = boss 
mod.toggleoptions = {"tranq", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.tranq and msg == L["tranq_trigger"] then
		self:Message(L["tranq_warning"], "Important")
		self:DelayedMessage(10, L["tranqfade_warning"], "Attention")
		self:Bar(L["tranq"], 15, "Spell_Nature_Tranquility")		
	end
end
