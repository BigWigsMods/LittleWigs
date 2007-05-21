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
	touchtimer_bar = "%s: Murmur's Touch",

	youtouch = "You are the bomb alert",
	youtouch_desc = "Warn when you are the bomb",

	elsetouch = "Someone else is the bomb alert",
	elsetouch_desc = "Warn when others are the bomb",

	icon = "Raid Icon on bomb",
	icon_desc = "Put a Raid Icon on the person who's the bomb. (Requires promoted or higher)",	

	sonicboom = "Sonic Boom",
	sonicboom_desc = "Warns when Murmur begins casting his Sonic Boom",
	sonicboom_trigger = "draws energy from the air...",
	sonicboom_alert = "Sonic Boom in 5 seconds!",
	sonicboom_bar = "Sonic Boom casting!",
} end)

L:RegisterTranslations("koKR", function() return {
	touch_trigger = "^([^|;%s]*)(.*)울림의 손길에 걸렸습니다%.$", -- check
	touch_message_you = "당신은 폭탄입니다!",
	touch_message_other = "%s님이 폭탄입니다!",

	touchtimer = "폭발 시점에 대한 바",
	touchtimer_desc = "울림의 손길에 걸린 사람이 폭발할 때 까지의 13초 바를 표시합니다.",
	touchtimer_bar = "%s: 울림의 손길",

	youtouch = "자신의 폭탄 알림",
	youtouch_desc = "당신이 폭탄일 때 알립니다.",

	elsetouch = "타인의 폭탄 알림",
	elsetouch_desc = "타인이 폭탄일 때 알립니다.",

	icon = "폭탄 공격대 아이콘",
	icon_desc = "폭탄인 사람에게 공격대 아이콘을 지정합니다. (승급자 이상 권한 요구)",

	sonicboom = "음파 폭발",
	sonicboom_desc = "음파 폭발 시전 시 경고합니다.",
	sonicboom_trigger = "대기에서 에너지를 흡수합니다...", -- check
	sonicboom_alert = "5초 이내 음파 폭발!",
	sonicboom_bar = "음파 폭발 시전!",
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
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
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

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L["sonicboom_trigger"]) then
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
			self:Bar(L["touchtimer_bar"]:format(player), 13, "Spell_Shadow_MindBomb", "Red")
		end

		if self.db.profile.icon then
			self:Icon(player)
		end
	elseif sync == "MurmurBoom" and self.db.profile.sonicboom then
		self:Message(L["sonicboom_alert"], "Important")
		self:Bar(L["sonicboom_bar"], 5, "Spell_Nature_AstralRecal", "Red")
	end
end
