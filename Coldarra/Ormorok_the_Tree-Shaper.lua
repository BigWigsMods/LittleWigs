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

	reflection = "Spell Reflection",
	reflection_desc = "Warn for Spell Reflection.",

	reflectionBar = "Spell Reflection Bar",
	reflectionBar_desc = "Show a bar for the duration of the Spell Reflection.",

	frenzy = "Frenzy",
	frenzy_desc = "Warn when Ormorok goes into a Frenzy.",
	frenzy_message = "Ormorok Frenzies",
} end )

L:RegisterTranslations("koKR", function() return {
	spikes = "수정 가시",
	spikes_desc = "수정 가시 시전을 알립니다.",

	reflection = "주문 반사",
	reflection_desc = "주문 반사를 알립니다.",

	reflectionBar = "주문 반사 대기시간",
	reflectionBar_desc = "주문 반사 대기시간에 대한 바입니다.",

	frenzy = "광기",
	frenzy_desc = "오르모로크의 광기를 알립니다.",
	frenzy_message = "오르모로크 광기",
} end )

L:RegisterTranslations("frFR", function() return {
	spikes = "Pointes de cristal",
	spikes_desc = "Prévient quand Ormorok est sur le point d'incanter des Pointes de cristal.",

	reflection = "Renvoi de sort",
	reflection_desc = "Prévient quand Ormorok renvoie les sorts.",

	reflectionBar = "Renvoi de sort - Barre",
	reflectionBar_desc = "Affiche une barre indiquant la durée du Renvoi de sort.",

	frenzy = "Frénésie",
	frenzy_desc = "Prévient quand Ormorok entre en frénésie.",
	frenzy_message = "Ormorok en frénésie",
} end )

L:RegisterTranslations("zhTW", function() return {
	spikes = "水晶尖刺",
	spikes_desc = "當施放水晶尖刺前發出警報。",

	reflection = "法術反射",
	reflection_desc = "當法術反射時發出警報。",

	reflectionBar = "法術反射計時條",
	reflectionBar_desc = "當法術反射持續時顯示計時條。",

	frenzy = "狂亂",
	frenzy_desc = "當『樹木造形者』歐爾莫洛克狂亂時發出警報。",
	frenzy_message = "『樹木造形者』歐爾莫洛克 - 狂亂！",
} end )

L:RegisterTranslations("deDE", function() return {
	spikes = "Kristallstacheln",
	spikes_desc = "Warnt bevor Kristallstacheln gewirkt werden.",

	reflection = "Zauberreflexion",
	reflection_desc = "Warnt vor Zauberreflexion.",

	reflectionBar = "Zauberreflexion Bar",
	reflectionBar_desc = "Zeige eine Bar für die Dauer der Zauberreflexion.",

	frenzy = "Raserei",
	frenzy_desc = "Warnt wenn Ormorok Raserei bekommt.",
	frenzy_message = "Ormorok gerät in Raserei",
} end )

L:RegisterTranslations("zhCN", function() return {
	spikes = "水晶之刺",
	spikes_desc = "当施放水晶之刺前发出警报。",

	reflection = "法术反射",
	reflection_desc = "当施放法术反射时发出警报。",

	reflectionBar = "法术反射计时条",
	reflectionBar_desc = "当法术反射持续时显示计时条。",

	frenzy = "狂乱",
	frenzy_desc = "当塑树者奥莫洛克狂乱时发出警报。",
	frenzy_message = "塑树者奥莫洛克 - 狂乱！",
} end )

-- Translated by StingerSoft
L:RegisterTranslations("ruRU", function() return {
	spikes = "Кристальные шипы",
	spikes_desc = "Предупреждать о применении кристальных шипов.",

	reflection = "Отражение заклинания",
	reflection_desc = "Предупреждать об отражении заклинаний",

	reflectionBar = "Полоса отражения заклинания",
	reflectionBar_desc = "Отображать полосу длительности отражения заклинания.",

	frenzy = "Бешенство",
	frenzy_desc = "Предупреждает о бешенстве Орморока.",
	frenzy_message = "Орморок взбесился",
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
mod.toggleoptions = {"spikes", "reflection", "reflectionBar", "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Reflection", 47981)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ReflectionRemoved", 47981)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Spikes", 47958, 57082, 57083)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Frenzy", 48017, 57086)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Spikes(_, spellId, _, _, spellName)
	if self.db.profile.spikes then
		self:IfMessage(spellName, "Attention", spellId)
	end
end

function mod:Reflection(_, spellId, _, _, spellName)
	if self.db.profile.reflection then
		self:IfMessage(spellName, "Attention", spellId)
	end
	if self.db.profile.reflectionBar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ReflectionRemoved(_, _, _, _, spellName)
	if self.db.profile.reflectionBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Frenzy(_, spellId)
	if self.db.profile.frenzy then
		self:IfMessage(L["frenzy_message"], "Important", spellId)
	end
end

