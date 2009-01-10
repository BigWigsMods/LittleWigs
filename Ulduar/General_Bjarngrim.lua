------------------------------
--      Are you local?      --
------------------------------

local boss = BB["General Bjarngrim"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Bjarngrim",

	mortalStrike = "Mortal Strike",
	mortalStrike_desc = "Warn when some has Mortal Strike debuff.",
	mortalStrike_message = "Mortal Strike: %s",

	mortalStrikeBar = "Mortal Strike Bar",
	mortalStrikeBar_desc = "Show a bar for the duration of the Mortal Strike debuff.",

	berserker = "Berserker Aura",
	berserker_desc = "Warn when General Bjarngrim gains and loses Berserker Aura.",
	berserker_applied = "Gained Berserker Aura",
	berserker_removed = "Berserker Aura Fades",
} end)

L:RegisterTranslations("deDE", function() return {
} end)

L:RegisterTranslations("frFR", function() return {
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
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28586
mod.toggleoptions = {"mortalStrike", "mortalStrikeBar", -1, "berserker", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "MortalStrike", 16856)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Berserker", 41107)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BerserkerRemoved", 41107)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MortalStrike(player, spellId)
	if self.db.profile.mortalStrike then
		self:IfMessage(L["mortalStrike_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.mortalStrikeBar then
		self:Bar(L["mortalStrike_message"]:format(player), 5, spellId)
	end
end

function mod:Berserker(target, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_applied"]:format(player), "Urgent", spellId)
	end
end

function mod:BerserkerRemoved(player, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_removed"], "Attention", spellId)
	end
end
