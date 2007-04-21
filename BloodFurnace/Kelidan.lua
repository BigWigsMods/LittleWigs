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

	nova = "Burning Nova Alert",
	nova_desc = "Warn for Burning Nova",
	nova_trigger = "Come closer",
	nova_message = "Burning Nova Incoming!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
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
		self:Message(L["nova_message"], "Attention")
	end
end
