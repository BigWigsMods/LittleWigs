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
	tranq = "寧靜",
	tranq_desc = "費瑞衛恩施放寧靜時發出警報",
	tranq_trigger = "自然順從我的意志……",
	tranq_warning = "費瑞衛恩施放寧靜了!",
	tranqfade_warning = "5 秒後寧靜消散!",
} end )

L:RegisterTranslations("frFR", function() return {
	tranq = "Tranquillité ",
	tranq_desc = "Préviens quand Freywinn lance sa Tranquillité.",
	tranq_trigger = "Nature bends to my will....", -- à traduire
	tranq_warning = "Tranquilité incanté !",
	tranqfade_warning = "Fin de Tranquillité dans ~5 sec. !",
} end )

L:RegisterTranslations("koKR", function() return {
	tranq = "평온",
	tranq_desc = "평온에 대한 경고",
	tranq_trigger = "자연의 힘이 내 손안에 있다...", -- check
	tranq_warning = "평온 시전!",
	tranqfade_warning = "약 5초 이내 평온 사라짐!",
} end )

L:RegisterTranslations("deDE", function() return {
	tranq = "Gelassenheit",
	tranq_desc = "Warnt vor Gelassenheit",
	tranq_trigger = "Die Natur unterwirft sich meinem Willen.",
	tranq_warning = "Gelassenheit wird gecastet!",
	tranqfade_warning = "Gelassenheit schwindet in ~5s!",
} end )

--高级植物学家弗雷温
L:RegisterTranslations("zhCN", function() return {
	tranq = "宁静",
	tranq_desc = "宁静警报",
	tranq_trigger = "自然的力量听我调遣……",
	tranq_warning = "宁静 施放!",
	tranqfade_warning = "5秒后 宁静消失!",
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
	if self.db.profile.tranq and msg == L["tranq_trigger"] then
		self:Message(L["tranq_warning"], "Important")
		self:DelayedMessage(10, L["tranqfade_warning"], "Attention")
		self:Bar(L["tranq"], 15, "Spell_Nature_Tranquility")
	end
end

