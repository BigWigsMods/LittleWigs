------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Mechano-Lord Capacitus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Capacitus",

	trigger1 = "gains Magic Reflection",
	trigger2 = "gains Damage Shield",
	trigger3 = "Magic Reflection fades",
	trigger4 = "Damage Shield fades",

	warn1 = "Magic Reflection up!",
	warn2 = "Damage Shield up!",
	warn3 = "Magic Reflection down!",
	warn4 = "Damage Shield down!",

	magic = "Magic Reflection alert",
	magic_desc = "Warn for Magic Reflection",

	dmg = "Damage Shields alert",
	dmg_desc = "Warn for Damage Shields",

} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"magic", "dmg", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
	aura = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if not aura and self.db.profile.magic and msg:find(L["trigger1"]) then
		self:NewPowers(1)
	elseif not aura and self.db.profile.dmg and msg:find(L["trigger2"]) then
		self:NewPowers(2)
	end
end

function mod:CHAT_MSG_SPELL_AURA_GONE_OTHER(msg)
	if aura and (msg:find(L["trigger3"]) or msg:find(L["trigger4"])) then
		self:Message(aura == 1 and L["warn3"] or L["warn4"], "Attention")
		aura = nil
	end
end

function mod:NewPowers(power)
	aura = power
	self:Message(power == 1 and L["warn1"] or L["warn2"], "Important")
end
