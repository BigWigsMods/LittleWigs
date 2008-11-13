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
	whirlwindcooldown_desc = "Warn when cooldown for Whirlwind has passed",
	whirlwindcooldown_message = "Whirlwind cooldown passed",

	whirlwindbars = "Whirlwind Bars",
	whirlwindbars_desc = "Show bars for the duration of the Whirlwind and it's cooldown.",

	whirlwind_cooldown_bar = "Whirlwind cooldown",
} end )

L:RegisterTranslations("koKR", function() return {
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
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
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
	self:AddCombatListener("SPELL_AURA_APPLIED", "Whirlwind", 59322)
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
		self:DelayedMessage(13, L["infernal_message"], "Attention")
	end
	if self.db.profile.whirlwindbars then
		self:Bar(spellName, 10, spellId)
		self:Bar(L["whirlwind_cooldown_bar"], 13, spellId)
	end
end
