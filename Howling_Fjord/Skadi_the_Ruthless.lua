------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Skadi the Ruthless"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Skadi",

	whirlwind = "Whirlwind",
	whirlwind_desc = "Warn when Skadi the Ruthless begins to Whirlwind.",

	whirlwindcooldown = "Whirlwind Cooldown",
	whirlwindcooldown_desc = "Warn when cooldown for Whirlwind has passed.",
	whirlwindcooldown_message = "Whirlwind cooldown passed",

	whirlwindbars = "Whirlwind Bars",
	whirlwindbars_desc = "Show bars for the duration of the Whirlwind and it's cooldown.",

	whirlwind_cooldown_bar = "Whirlwind cooldown",
} end )

L:RegisterTranslations("koKR", function() return {
	whirlwind = "소용돌이",
	whirlwind_desc = "학살자 스카디의 소용돌이 시작을 알립니다.",

	whirlwindcooldown = "소용돌이 대기시간",
	whirlwindcooldown_desc = "소용돌이 대기시간을 알립니다.",
	whirlwindcooldown_message = "소용돌이 대기시간 종료",

	whirlwindbars = "소용돌이 바",
	whirlwindbars_desc = "소용돌이의 지속시간과 대기시간을 바로 표시합니다.",

	whirlwind_cooldown_bar = "소용돌이 대기시간",
} end )

L:RegisterTranslations("frFR", function() return {
	whirlwind = "Tourbillon",
	whirlwind_desc = "Prévient quand Skadi commence son Tourbillon.",

	whirlwindcooldown = "Tourbillon - Recharge",
	whirlwindcooldown_desc = "Prévient quand le temps de recharge de Tourbillon est terminé",
	whirlwindcooldown_message = "Fin du temps de recharge de Tourbillon",

	whirlwindbars = "Tourbillon - Barres",
	whirlwindbars_desc = "Affiche des barres indiquant la durée du Tourbillon ainsi que son temps de recharge.",

	whirlwind_cooldown_bar = "Recharge Tourbillon",
} end )

L:RegisterTranslations("zhTW", function() return {
	whirlwind = "旋風斬",
	whirlwind_desc = "當無情的斯卡迪開始旋風斬時發出警報。",

	whirlwindcooldown = "旋風斬冷卻",
	whirlwindcooldown_desc = "當旋風斬冷卻結束時擦除警報。",
	whirlwindcooldown_message = "旋風斬 冷卻結束！",

	whirlwindbars = "旋風斬計時條",
	whirlwindbars_desc = "當旋風斬持續和冷卻時顯示計時條。",

	whirlwind_cooldown_bar = "<旋風斬 冷卻>",
} end )

L:RegisterTranslations("deDE", function() return {
	whirlwind = "Wirbelwind",
	whirlwind_desc = "Warnt wenn Skadi der Skrupellose Wirbelwind wirkt.",

	whirlwindcooldown = "Wirbelwind Cooldown",
	whirlwindcooldown_desc = "Warnt wenn der Cooldown für Wirbelwind frei ist.",
	whirlwindcooldown_message = "Wirbelwind Cooldown Vorbei",

	whirlwindbars = "Wirbelwind Bars",
	whirlwindbars_desc = "Zeige Bars für die Dauer von Wirbelwind und dessen Cooldown.",

	whirlwind_cooldown_bar = "Whirlwind Cooldown",
} end )

L:RegisterTranslations("zhCN", function() return {
	whirlwind = "旋风斩",
	whirlwind_desc = "当残忍的斯卡迪旋风斩时发出警报。",

	whirlwindcooldown = "旋风斩冷却",
	whirlwindcooldown_desc = "当旋风斩冷却结束时发出警报。",
	whirlwindcooldown_message = "旋风斩 冷却结束！",

	whirlwindbars = "旋风斩计时条",
	whirlwindbars_desc = "当旋风斩持续和冷却时显示计时条。",

	whirlwind_cooldown_bar = "<旋风斩 冷却>",
} end )

L:RegisterTranslations("ruRU", function() return {
	whirlwind = "Вихрь",
	whirlwind_desc = "Предупреждать, когда Skadi the Ruthless использует вихрь.",

	whirlwindcooldown = "Перезарядка вихря",
	whirlwindcooldown_desc = "Предупреждать об окончании перезарядки вихря",
	whirlwindcooldown_message = "Перезарядка вихря завершена",

	whirlwindbars = "Полоса вихря",
	whirlwindbars_desc = "Отображать полосу продолжительности вихря и его перезарядки.",

	whirlwind_cooldown_bar = "Перезарядка вихря",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26693
mod.toggleoptions = {"whirlwind", "whirlwindcooldown", "whirlwindbars", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Whirlwind", 59322, 50228)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Whirlwind(_, spellId, _, _, spellName)
	if self.db.profile.whirlwind then
		self:IfMessage(spellName, "Urgent", spellId)
	end
	if self.db.profile.whirlwindcooldown then
		self:DelayedMessage(23, L["whirlwindcooldown_message"], "Attention")
	end
	if self.db.profile.whirlwindbars then
		self:Bar(spellName, 10, spellId)
		self:Bar(L["whirlwind_cooldown_bar"], 23, spellId)
	end
end
