------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Dalliah the Doomsayer"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Dalliah",

	ww = "Whirlwind",
	ww_desc = "Warns for Dalliah's Whirlwind",
	ww_trigger1 = "I'll cut you to pieces!",
	ww_trigger2 = "Reap the whirlwind!",
	-- Could be more yell triggers
	ww_message = "Dalliah begins to Whirlwind!",

	gift = "Gift of the Doomsayer",
	gift_desc = "Warns for Dalliah's Gift of the Doomsayer debuff",
	gift_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	gift_message = "%s has Gift of the Doomsayer!",
	gift_bar = "Gifted: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	ww = "소용돌이",
	ww_desc = "달리아의 소용돌이에 대한 경고",
	ww_trigger1 = "산산조각 내 버리겠어!",
	ww_trigger2 = "소용돌이를 받아라!",
	-- Could be more yell triggers
	ww_message = "달리아 소용돌이 시작!",

	gift = "파멸의 예언자의 선물",
	gift_desc = "달리아의 파멸의 예언자의 선물 디버프에 대한 알림",
	gift_trigger = "^([^|;%s]*)(.*)파멸의 예언자의 선물에 걸렸습니다%.$",
	gift_message = "%s 파멸의 예언자의 선물!",
	gift_bar = "예언자의 선물: %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	ww = "旋風斬",
	ww_desc = "旋風斬警報",
	ww_trigger1 = "我將把你碎屍萬段!",
	ww_trigger2 = "獲得了旋風斬的效果。",
	-- Could be more yell triggers
	ww_message = "達利亞要發動旋風斬了！",

	gift = "末日預言者的賜福",
	gift_desc = "達利亞獲得末日預言者的賜福時發出警報",
	gift_trigger = "^(.+)受到(.*)末日預言者的賜福效果的影響。",
	gift_message = "%s 受到末日預言者的賜福的傷害！",
	gift_bar = "賜福: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	ww = "Tourbillon",
	ww_desc = "Préviens quand Dalliah fait son Tourbillon.",
	ww_trigger1 = "I'll cut you to pieces!", -- à traduire
	ww_trigger2 = "Reap the whirlwind!", -- à traduire
	-- Could be more yell triggers
	ww_message = "Dalliah gagne Tourbillon !",

	gift = "Don de l'auspice funeste",
	gift_desc = "Préviens quand quelqu'un est affecté par le Don de l'auspice funeste.",
	gift_trigger = "^([^%s]+) ([^%s]+) les effets .* Don de l'auspice funeste.",
	gift_message = "%s a le Don de l'auspice funeste !",
	gift_bar = "Don : %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"ww", "gift", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.ww then return end
	if msg == L["ww_trigger1"] or msg == L["ww_trigger2"] then
		self:Message(L["ww_message"], "Important")
		self:Bar(L["ww"], 6, "Ability_Whirlwind")
	end
end

function mod:Event(msg)
	if not self.db.profile.gift then return end
	local player, type = select(3, msg:find(L["gift_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["gift_message"]:format(player), "Urgent")
		self:Bar(L["gift_bar"]:format(player), 10, "Spell_Shadow_AntiShadow")
	end
end
