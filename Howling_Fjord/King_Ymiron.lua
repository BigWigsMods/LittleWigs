------------------------------
--      Are you local?      --
------------------------------

local boss = BB["King Ymiron"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ymiron",

	bane = "Bane",
	bane_desc = "Warn for the casting of Bane.",
	bane_message = "Casting Bane",

	banebar = "Bane Bar",
	banebar_desc = "Display a bar for the duration of the Bane buff.",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
	bane = "Fléau",
	bane_desc = "Prévient quand Ymiron incante Fléau.",
	bane_message = "Fléau en incantation",

	banebar = "Fléau - Barre",
	banebar_desc = "Affiche une barre indiquant la durée du buff Fléau.",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	bane = "Погибель",
	bane_desc = "Предепреждать о применении Погибели.",
	bane_message = "Применение Погибели",

	banebar = "Полоса Погибели",
	banebar_desc = "Отображать полосу продолжительности баффа Погибели.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26861
mod.toggleoptions = {"bane", "banebar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Bane", 48294)
	self:AddCombatListener("SPELL_AURA_APPLIED", "BaneAura", 48294)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BaneAuraRemoved", 48294)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Bane(_, spellId, _, _, spellName)
	if self.db.profile.bane then
		self:IfMessage(L["bane_message"], "Urgent", spellId)
	end
end

function mod:BaneAura(_, spellId, _, _, spellName)
	if self.db.profile.banebar then
		self:Bar(spellName, 5, spellId)
	end
end

function mod:BaneAuraRemoved(_, _, _, _, spellName)
	if self.db.profile.banebar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end
