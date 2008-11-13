------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ormorok the Tree-Shaper"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ormorok",

	spikes = "Crystal Spikes",
	spikes_desc = "Warn before Crystal Spikes are cast.",
	spikes_message = "Crystal Spikes",

	reflection = "Spell Reflection",
	reflection_desc = "Warn for Spell Reflection.",
	reflection_message = "Spell Reflection",

	reflectionbar = "Spell Reflection Bar",
	reflectionbar_desc = "Show a bar for the duration of the Spell Reflection.",

	frenzy = "Frenzy",
	frenzy_desc = "Warn when Ormorok goes into a Frenzy.",
	frenzy_message = "Ormorok Frenzies",
} end )

L:RegisterTranslations("koKR", function() return {
	spikes = "¼öÁ¤ °¡½Ã",
	spikes_desc = "¼öÁ¤ °¡½Ã ½ÃÀüÀ» ¾Ë¸³´Ï´Ù.",
	spikes_message = "Àá½Ã ÈÄ ¼öÁ¤ °¡½Ã",

	reflection = "ÁÖ¹® ¹Ý»ç",
	reflection_desc = "ÁÖ¹® ¹Ý»ç¸¦ ¾Ë¸³´Ï´Ù.",
	reflection_message = "ÁÖ¹® ¹Ý»ç!",

	reflectionbar = "ÁÖ¹® ¹Ý»ç ¹Ù",
	reflectionbar_desc = "ÁÖ¹® ¹Ý»çÀÇ Áö¼Ó ¹Ù¸¦ º¸¿©ÁÝ´Ï´Ù.",

	frenzy = "±¤±â",
	frenzy_desc = "¿À¸£¸ð·ÎÅ©ÀÇ ±¤±â¸¦ ¾Ë¸³´Ï´Ù.",
	frenzy_message = "¿À¸£¸ð·ÎÅ© ±¤±â",
} end )

L:RegisterTranslations("frFR", function() return {
	spikes = "Pointes de cristal",
	spikes_desc = "Prévient quand Ormorok est sur le point d'incanter des Pointes de cristal.",
	spikes_message = "Pointes de cristal",

	reflection = "Renvoi de sort",
	reflection_desc = "Prévient quand Ormorok renvoie les sorts.",
	reflection_message = "Renvoi de sort",

	reflectionbar = "Renvoi de sort - Barre",
	reflectionbar_desc = "Affiche une barre indiquant la durée du Renvoi de sort.",

	frenzy = "Frénésie",
	frenzy_desc = "Prévient quand Ormorok entre en frénésie.",
	frenzy_message = "Ormorok en frénésie",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )
-- Translated by StingerSoft
L:RegisterTranslations("ruRU", function() return {
	spikes = "Кристальные шипы",
	spikes_desc = "Предупреждает о применении Кристальных шипов.",
	spikes_message = "Кристальные шипы",

	reflection = "Отражение заклинания",
	reflection_desc = "Предупреждает о отражении заклинаний",
	reflection_message = "Отражение заклинаний",

	reflectionbar = "Полоса Отражения заклинания",
	reflectionbar_desc = "Отображение полосы длительности Отражения заклинания.",

	frenzy = "Бешенство",
	frenzy_desc = "Предупреждает о бешенстве Ormorok.",
	frenzy_message = "Ormorok взбесился",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26794
mod.toggleoptions = {"spikes", "reflection", "reflectionbar", "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Reflection", 47981)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ReflectionRemoved", 47981)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Spikes", 47958)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Frenzy", 48017)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Spikes(_, spellId)
	if self.db.profile.spikes then
		self:IfMessage(L["spikes_message"], "Attention", spellId)
	end
end

function mod:Reflection(_, spellId, _, _, spellName)
	if self.db.profile.reflection then
		self:IfMessage(L["reflection_message"], "Attention", spellId)
	end
	if self.db.profile.reflectionbar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ReflectionRemoved(_, _, _, _, spellName)
	if self.db.profile.reflectionbar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Frenzy(_, spellId)
	if self.db.profile.frenzy then
		self:IfMessage(L["frenzy_message"], "Important", spellId)
	end
end

