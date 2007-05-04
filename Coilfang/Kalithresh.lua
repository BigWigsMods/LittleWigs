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
	rage_trigger = "^%s begins to channel",
	rage_message = "Warlord is channeling!",

	--ragegone_trigger = "Warlord's Rage fades from", --need a working trigger
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
	--aura = 0
	--self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
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

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if self.db.profile.rage and msg:find(L["rage_trigger"]) then
		self:Message(L["rage_message"], "Attention")
	end
end

--[[ can probably just shedule this, doesn't work atm so commented out, need the time from start > end, either that or maybe theres a death message for the distillers
function mod:CHAT_MSG_SPELL_AURA_GONE_OTHER(msg)
	if msg:find(L["ragegone_trigger"]) then
		aura = 0
	end
end
]]
