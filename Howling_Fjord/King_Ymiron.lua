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
	bane = "災禍",
	bane_desc = "當施放災禍時發出警報。",
	bane_message = "正在施放 災禍！",

	banebar = "災禍計時條",
	banebar_desc = "當災禍持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	bane = "灾祸",
	bane_desc = "当施放灾祸时发出警报。",
	bane_message = "正在施放 灾祸！",

	banebar = "灾祸计时条",
	banebar_desc = "当灾祸持续是显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	bane = "Погибель",
	bane_desc = "Предепреждать о применении погибели.",
	bane_message = "Применение погибели",

	banebar = "Полоса погибели",
	banebar_desc = "Отображать полосу продолжительности баффа погибели.",
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
