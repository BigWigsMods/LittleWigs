------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Grandmaster Vorpil"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Vorpil",

	teleport = "Teleport Alert",
	teleport_desc = "Warn for Teleport",
	teleport_trigger = "The darkness in your",
	teleport_message = "Teleport!",
} end )

L:RegisterTranslations("koKR", function() return {


} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"teleport", "bosskill"}
mod.revision = tonumber(("$Revision: 33724 $"):sub(12, -3))

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
	if self.db.profile.teleport and msg:find(L["teleport_trigger"]) then
		self:Message(L["teleport_message"], "Attention")
	end
end
