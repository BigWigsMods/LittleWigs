------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Sjonnir The Ironshaper"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Sjonnir",

	charge = "Static Charge",
	charge_desc = "Warn for who has the Static Charge.",

	chargeBar = "Static Charge Bar",
	chargeBar_desc = "Display a bar for the duraction of the Static Charge debuff.",

	charge_message = "Static Charge: %s",

	ring = "Lightning Ring",
	ring_desc = "Warn for Lightning Ring.",

	ringBar = "Lightning Ring Cast Bar",
	ringBar_desc = "Display a channel casting bar for Lightning Ring.",

	ring_message = "Lightning Ring!",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	charge = "Charge statique",
	charge_desc = "Prévient quand un joueur subit les effets de la Charge statique.",
	charge_message = "%s : Charge statique",

	ring = "Anneau de foudre",
	ring_desc = "Prévient de l'arrivée de l'Anneau de foudre.",
	ring_message = "Anneau de foudre !",
} end)

L:RegisterTranslations("koKR", function() return {
	charge = "전하 충전",
	charge_desc = "전하 충전에 걸린 플레이어를 알립니다.",
	charge_message = "전하 충전: %s",

	ring = "번개 고리",
	ring_desc = "번개 고리를 알립니다.",
	ring_message = "번개 고리!",
} end)

L:RegisterTranslations("zhCN", function() return {
	charge = "静电充能",
	charge_desc = "当玩家中了静电充能时发出警报。",
	charge_message = ">%s<：静电充能！",

	ring = "闪电之环",
	ring_desc = "当施放闪电之环时发出警报。",
	ring_message = "闪电之环！",
} end)

L:RegisterTranslations("zhTW", function() return {
	charge = "靜電能量",
	charge_desc = "當玩家中了靜電能量時發出警報。",
	charge_message = ">%s<：靜電能量！",

	ring = "閃電環",
	ring_desc = "當施放閃電環時發出警報。",
	ring_message = "閃電環！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	charge = "Статический заряд",
	charge_desc = "Предупреждать, когда кто-нибудь статически заряжен.",

	chargeBar = "Полоса Статического заряда",
	chargeBar_desc = "Отображение полосы продолжительности дебаффа Статического заряда.",

	charge_message = "%s: статически заряжен",

	ring = "Кольцо молний",
	ring_desc = "Предупреждать о кольце молний.",

	ringBar = "Полоса Кольца молний",
	ringBar_desc = "Отображать полосу применения Кольца молний.",

	ring_message = "Кольцо молний!",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27978
mod.toggleoptions = {"charge","ring","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Charge", 50834, 59846)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Ring", 50840, 59848, 59861, 51849)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Charge(player, spellId)
	if self.db.profile.charge then
		self:IfMessage(L["charge_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.chargeBar then
		self:Bar(L["charge_message"]:format(player), 10, spellId)
	end
end

function mod:Ring(_, spellId)
	if self.db.profile.ring then
		self:IfMessage(L["ring_message"], "Urgent", spellId)
	end
	if self.db.profile.ringBar then
		self:Bar(L["ring_message"], 10, spellId)
	end
end
