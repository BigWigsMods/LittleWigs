------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Herald Volazj"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Volazj",

	insanity = "Insanity",
	insanity_desc = "Warn when Herald Volazj begins to cast Insanity.",
	insanity_message = "Casting Insanity",
	
	shiver = "Shiver",
	shiver_desc = "Warn for who has the Shiver debuff",
	shiver_message = "Shiver: %s",
	
	shiverBar = "Shiver Bar",
	shiverBar_desc = "Show a bar for the duration of the Shiver debuff.",
} end)

L:RegisterTranslations("deDE", function() return {
	insanity = "Wahnsinn",
	insanity_desc = "Warnung wenn Herald Volazj mit dem Zaubern von Wahnsinn beginnt.",
	insanity_message = "Wirkt Wahnsinn!",
	
	shiver = "Schaudern",
	shiver_desc = "Warnung wer von Schaudern betroffen ist.",
	shiver_message = "Schaudern: %s",
	
	shiverBar = "Schaudern-Anzeige",
	shiverBar_desc = "Eine Leiste f\195\188r die Dauer von Schaudern anzeigen.",
} end)

L:RegisterTranslations("frFR", function() return {
	insanity = "Insanité",
	insanity_desc = "Prévient quand le Hérault Volazj commence à incanter Insanité.",
	insanity_message = "Insanité en incantation",

	shiver = "Frisson",
	shiver_desc = "Prévient quand un joueur subit les effets du Frisson",
	shiver_message = "Frisson : %s",

	shiverBar = "Frisson - Barre",
	shiverBar_desc = "Affiche une barre indiquant la durée du Frisson.",
} end)

L:RegisterTranslations("koKR", function() return {
	insanity = "정신 이상",
	insanity_desc = "사자 볼라즈의 정신 이상 시전을 알립니다.",
	insanity_message = "정신 이상 시전!",
	
	shiver = "오한",
	shiver_desc = "오한 디버프에 걸린 플레이어를 알립니다.",
	shiver_message = "오한: %s",
	
	shiverBar = "오한 바",
	shiverBar_desc = "오한 디버프의 지속 바를 표시합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	insanity = "疯狂",
	insanity_desc = "当传令官沃拉兹开始施放疯狂时发出警报。",
	insanity_message = "正在施放 疯狂！",
	
	shiver = "碎裂",
	shiver_desc = "当玩家中了碎裂减益时发出警报。",
	shiver_message = "碎裂：%s！",
	
	shiverBar = "碎裂计时条",
	shiverBar_desc = "当碎裂减益持续时显示计时条。",
} end)

L:RegisterTranslations("zhTW", function() return {
	insanity = "瘋狂",
	insanity_desc = "當信使沃菈齊開始施放瘋狂時發出警報。",
	insanity_message = "正在施放 瘋狂！",
	
	shiver = "碎顫",
	shiver_desc = "當玩家中了碎顫減益時發出警報。",
	shiver_message = "碎顫：%s！",
	
	shiverBar = "碎顫計時條",
	shiverBar_desc = "當碎顫減益持續時顯示計時條。",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	insanity = "Безумие",
	insanity_desc = "Предупреждать когда Herald Volazj начинает применять Безумие.",
	insanity_message = "Применяется Безумие",
	
	shiver = "Трепет",
	shiver_desc = "Предупреждать на кого наложен дебафф Трепет",
	shiver_message = "Трепет на: %s",
	
	shiverBar = "Полоса Трепета",
	shiverBar_desc = "Отображать полосу продолжительности дебаффа Трепета.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29311
mod.toggleoptions = {"insantiy",-1,"shiver","shiverBar","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Insanity", 57496)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shiver", 57949, 59978)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShiverRemoved", 57949, 59978)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Insanity(_, spellId)
	if self.db.profile.insanity then
		self:IfMessage(L["insanity_message"], "Important", spellId)
	end
end

function mod:Shiver(player, spellId, _, _, spellName)
	if self.db.profile.shiver then
		self:IfMessage(L["shiver_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.shiverBar then
		self:Bar(L["shiver_message"]:format(player), 15, spellId)
	end
end

function mod:ShiverRemoved(player)
	if self.db.profile.shiverBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["shiver_message"]:format(player))
	end
end

