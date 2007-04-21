------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Murmur"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Murmur",

	touch_trigger = "^([^%s]+) ([^%s]+) afflicted by Murmur's Touch.",
	touch_message_you = "You are the bomb!",
	touch_message_other = "%s is the bomb!",

	touchtimer = "Bar for when the bomb goes off",
	touchtimer_desc = "Shows a 13 second bar for when the bomb goes off at the target.",

	youtouch = "You are the bomb alert",
	youtouch_desc = "Warn when you are the bomb",

	elsetouch = "Someone else is the bomb alert",
	elsetouch_desc = "Warn when others are the bomb",

	icon = "Raid Icon on bomb",
	icon_desc = "Put a Raid Icon on the person who's the bomb. (Requires promoted or higher)",	

	sonicboom = "Sonic Boom",
	sonicboom_desc = "Warns when Murmur begins casting his Sonic Boom",
	sonicboom_trigger = "Murmur begins to cast Sonic Boom.",
	sonicboom_alert = "Sonic Boom in 5 seconds!",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = AceLibrary("Babble-Zone-2.2")["Shadow Labyrinth"]
mod.enabletrigger = boss
mod.toggleoptions = {"sonicboom", -1, "touchtimer", "youtouch", "elsetouch", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")

	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "MurmurBoom", 2)
	self:TriggerEvent("BigWigs_ThrottleSync", "MurmurTouch", 2)
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Event(msg)
	local player, type = select(3, msg:find(L["touch_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Sync("MurmurTouch "..player)
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if msg == L["sonicboom_trigger"] then
		self:Sync("MurmurBoom")
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if sync == "MurmurTouch" and rest then
		local player = rest

		if player == UnitName("player") and self.db.profile.youtouch then
			self:Message(L["touch_message_you"], "Personal", true)
			self:Message(L["touch_message_other"]:format(player), "Attention", nil, nil, true)
		elseif self.db.profile.elsetouch then
			self:Message(L["touch_message_other"]:format(player), "Attention")
			self:Whisper(player, L["touch_message_you"])
		end

		if self.db.profile.touchtimer then
			self:Bar(L["bombtimer_bar"]:format(player), 13, "Spell_Shadow_MindBomb", "Red")
		end

		if self.db.profile.icon then
			self:Icon(player)
		end
	elseif sync == "MurmurBoom" and self.db.profile.sonicboom then
		self:Message(L["sonicboom_alert"], "Important")
	end
end
