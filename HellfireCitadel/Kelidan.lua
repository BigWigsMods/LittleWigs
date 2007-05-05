------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Keli'dan the Breaker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Keli'dan",

	nova = "Burning Nova",
	nova_desc = "Warn for Burning Nova",
	nova_trigger = "Come closer",
	nova_message = "Burning Nova Incoming!",
} end )

L:RegisterTranslations("koKR", function() return {
	nova = "불타는 회오리",
	nova_desc = "불타는 회오리에 대한 경고",
	nova_trigger = "가까이.. 더 가까이..", -- check
	nova_message = "불타는 회오리 시전!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "bosskill"}
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
	if self.db.profile.nova and msg:find(L["nova_trigger"]) then
		self:Message(L["nova_message"], "Important")
	end
end
