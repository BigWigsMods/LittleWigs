------------------------------
--      Are you local?      --
------------------------------

local boss = BB["High Botanist Freywinn"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Freywinn",

	tranq = "Tranquility",
	tranq_desc = "Warn for Tranquility",
	tranq_message = "Tranquility cast!",
	tranqfade_message = "Tranquility fading in ~5s!",
} end )

L:RegisterTranslations("zhTW", function() return {
	tranq = "寧靜",
	tranq_desc = "費瑞衛恩施放寧靜時發出警報",
	tranq_message = "費瑞衛恩施放寧靜了!",
	tranqfade_message = "5 秒後寧靜消散!",
} end )

L:RegisterTranslations("frFR", function() return {
	tranq = "Tranquillité",
	tranq_desc = "Prévient quand Freywinn lance sa Tranquillité.",
	tranq_message = "Tranquilité incanté !",
	tranqfade_message = "Fin de la Tranquillité dans ~5 sec. !",
} end )

L:RegisterTranslations("koKR", function() return {
	tranq = "평온",
	tranq_desc = "평온에 대해 알립니다.",
	tranq_message = "평온 시전!",
	tranqfade_message = "약 5초 이내 평온 사라짐!",
} end )

L:RegisterTranslations("deDE", function() return {
	tranq = "Gelassenheit",
	tranq_desc = "Warnt vor Gelassenheit",
	tranq_message = "Gelassenheit wird gecastet!",
	tranqfade_message = "Gelassenheit schwindet in ~5s!",
} end )

L:RegisterTranslations("zhCN", function() return {
	tranq = "宁静",
	tranq_desc = "当施放宁静时发出警报。",
	tranq_message = "宁静 施放！",
	tranqfade_message = "5秒后，宁静消失！",
} end )

L:RegisterTranslations("ruRU", function() return {
	tranq = "Спокойствие",
	tranq_desc = "Предупреждать о Спокойствии",
	tranq_message = "Произноситься Спокойствие!",
	tranqfade_message = "Спокойствие закончится за ~5с!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.guid = 17975
mod.toggleOptions = {"tranq"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("SPELL_CAST_SUCCESS", "Tranq", 34550)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Tranq()
	if self.db.profile.tranq then
		self:Message(L["tranq_message"], "Important")
		self:DelayedMessage(10, L["tranqfade_message"], "Attention")
		self:Bar(L["tranq"], 15, "Spell_Nature_Tranquility")
	end
end

