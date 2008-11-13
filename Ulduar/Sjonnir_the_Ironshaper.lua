------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Sjonnir the Ironshaper"]
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
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "Soft, vulnerable shells. Brief, fragile lifes. You can not escape the curse of flesh!",

	charge = "Статический заряд",
	charge_desc = "Предупреждать если кто Статический заряжен.",
	charge_message = "%s: Статический заряжен",

	ring = "Кольцо молний",
	ring_desc = "Предупреждать о Кольце молний.",
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
	self:AddCombatListener("SPELL_AURA_APPLIED", "Charge", 50834)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ChargeRemoved", 50834)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Ring", 50840, 59849)
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
