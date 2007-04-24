------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Darkweaver Syth"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Syth",

	summon = "Elementals Alert",
	summon_desc = "Warn for Summoned Elementals",
	summon_trigger = "casts Summon Syth Arcane Elemental",
	summon_message = "Elementals Summoned!",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "정령 알림",
	summon_desc = "정령 소환 시 알립니다.",
	summon_trigger = "나도... 부하들이 있다!", -- "casts Summon Syth Arcane Elemental",
	summon_message = "정령 소환!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Sethekk Halls"]
mod.enabletrigger = boss 
mod.toggleoptions = {"summon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.summon and msg:find(L["summon_trigger"]) then
		self:Message(L["summon_message"], "Attention")
	end
end
