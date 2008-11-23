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

	engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!",

	charge = "Static Charge",
	charge_desc = "Warn for who has the Static Charge.",
	charge_message = "%s: Static Charge",

	ring = "Lightning Ring",
	ring_desc = "Warn for Lightning Ring.",
	ring_message = "Lightning Ring!",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Des enveloppes frêles et vulnérables. Des vies fragiles et brèves. Vous n'échapperez pas à la malédiction de la chair !",

	charge = "Charge statique",
	charge_desc = "Prévient quand un joueur subit les effets de la Charge statique.",
	charge_message = "%s : Charge statique",

	ring = "Anneau de foudre",
	ring_desc = "Prévient de l'arrivée de l'Anneau de foudre.",
	ring_message = "Anneau de foudre !",
} end)

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!",	--check

	charge = "전하 충전",
	charge_desc = "전하 충전에 걸린 플레이어를 알립니다.",
	charge_message = "전하 충전: %s",

	ring = "번개 고리",
	ring_desc = "번개 고리를 알립니다.",
	ring_message = "번개 고리!",
} end)

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!", -- not yet

	charge = "静电充能",
	charge_desc = "当玩家中了静电充能时发出警报。",
	charge_message = ">%s<：静电充能！",

	ring = "闪电之环",
	ring_desc = "当施放闪电之环时发出警报。",
	ring_message = "闪电之环！",
} end)

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!", -- not yet

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

	log = "|cffff0000"..boss.."|r: Для этого босса необходимы правильные данные. Пожалуйста, включите запись логов (команда /combatlog) или установите аддон transcriptor, и пришлите получившийся файл (или оставьте ссылку на файл в комментариях на curse.com).",

	--engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!",

	charge = "Статический заряд",
	charge_desc = "Предупреждать, когда кто-нибудь статически заряжен.",
	charge_message = "%s: Статически заряжен",

	ring = "Кольцо молний",
	ring_desc = "Предупреждать о кольце молний.",
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
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Charge", 50834, 59846)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ChargeRemoved", 50834, 59846)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Ring", 50840, 59849, 59861, 51849)
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Charge(player, spellId)
	if self.db.profile.charge then
		self:IfMessage(L["charge_message"]:format(player), "Urgent", spellId)
		self:Bar(L["charge_message"]:format(player), 10, spellId)
	end
end

function mod:ChargeRemoved(player)
	if self.db.profile.charge then
		self:TriggerEvent("BigWigs_StopBar", self, L["charge_message"]:format(player))
	end
end

function mod:Ring(_, spellId)
	if self.db.profile.ring then
		self:IfMessage(L["ring_message"], "Urgent", spellId)
		self:Bar(L["ring_message"], 10, spellId)
	end
end