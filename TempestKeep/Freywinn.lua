------------------------------
--      Are you local?      --
------------------------------

local boss = BB["High Botanist Freywinn"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Freywinn",

	tranq = "Tranquility",
	tranq_desc = "Warn for Tranquility",
	tranq_trigger1 = "Nature bends to my will....",
	tranq_trigger2 = "Endorel anuminor!",
	tranq_message = "Tranquility cast!",
	tranqfade_message = "Tranquility fading in ~5s!",
} end )

L:RegisterTranslations("zhTW", function() return {
	tranq = "寧靜",
	tranq_desc = "費瑞衛恩施放寧靜時發出警報",
	tranq_trigger1 = "自然順從我的意志……",
	tranq_trigger2 = "Endorel anuminor!", --needs localization
	tranq_message = "費瑞衛恩施放寧靜了!",
	tranqfade_message = "5 秒後寧靜消散!",
} end )

L:RegisterTranslations("frFR", function() return {
	tranq = "Tranquillité ",
	tranq_desc = "Préviens quand Freywinn lance sa Tranquillité.",
	tranq_trigger1 = "Nature bends to my will....", -- à traduire
	tranq_trigger2 = "Endorel anuminor!", --needs localization
	tranq_message = "Tranquilité incanté !",
	tranqfade_message = "Fin de Tranquillité dans ~5 sec. !",
} end )

L:RegisterTranslations("koKR", function() return {
	tranq = "평온",
	tranq_desc = "평온에 대한 경고",
	tranq_trigger1 = "자연의 힘이 내 손안에 있다...",
	tranq_trigger2 = "엔도렐 아누미노르!",
	tranq_message = "평온 시전!",
	tranqfade_message = "약 5초 이내 평온 사라짐!",
} end )

L:RegisterTranslations("deDE", function() return {
	tranq = "Gelassenheit",
	tranq_desc = "Warnt vor Gelassenheit",
	tranq_trigger1 = "Die Natur unterwirft sich meinem Willen.",
	tranq_trigger2 = "Endorel anuminor!", --needs localization	
	tranq_message = "Gelassenheit wird gecastet!",
	tranqfade_message = "Gelassenheit schwindet in ~5s!",
} end )

L:RegisterTranslations("zhCN", function() return {
	tranq = "宁静",
	tranq_desc = "宁静警报",
	tranq_trigger1 = "自然的力量听我调遣……",
	tranq_trigger2 = "Endorel anuminor！",
	tranq_message = "宁静 施放!",
	tranqfade_message = "5秒后 宁静消失!",
} end )
----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.toggleoptions = {"tranq", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.tranq and (msg == L["tranq_trigger1"] or msg == L["tranq_trigger2"])then
		self:Message(L["tranq_message"], "Important")
		self:DelayedMessage(10, L["tranqfade_message"], "Attention")
		self:Bar(L["tranq"], 15, "Spell_Nature_Tranquility")
	end
end
