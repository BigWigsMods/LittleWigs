------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gortok Palehoof"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Gortok",

	roar = "Withering Roar",
	roar_desc = "Show the Withering Roar timer bar.",
	roarcooldown_bar = "Roar cooldown",

	impale = "Impale",
	impale_desc = "Warn who has Impale.",
	impale_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	roar = "부패의 포효",
	roar_desc = "부패의 포효 타이머 바를 표시합니다.",
	roarcooldown_bar = "포효 대기시간",

	impale = "꿰뚫기",
	impale_desc = "꿰뚫기에 걸린 플레이어를 알립니다.",
	impale_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	roar = "Rugissement d'affliction",
	roar_desc = "Affiche une barre indiquant le temps de recharge du Rugissement d'affliction.",
	roarcooldown_bar = "Recharge Rugissement",

	impale = "Empaler",
	impale_desc = "Prévient quand un joueur subit les effets d'Empaler.",
	impale_message = "%s : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	roar = "枯萎咆哮",
	roar_desc = "顯示枯萎咆哮計時條。",
	roarcooldown_bar = "<枯萎咆哮 冷卻>",
	
	impale = "刺穿",
	impale_desc = "當玩家中了刺穿時發出警報。",
	impale_message = "%s：>%s<！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	roar = "枯萎咆哮",
	roar_desc = "显示枯萎咆哮计时条。",
	roarcooldown_bar = "<枯萎咆哮 冷却>",
	
	impale = "穿刺",
	impale_desc = "当玩家中了穿刺时发出警报。",
	impale_message = "%s：>%s<！",
} end )

L:RegisterTranslations("ruRU", function() return {
	roar = "Губительный рев",
	roar_desc = "Отображать таймер губительного рева.",
	roarcooldown_bar = "Перезарядка рева",

	impale = "Прокалывание",
	impale_desc = "Сообщить в кого бросили копье.",
	impale_message = "%s: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26687
mod.toggleoptions = {"roar", "impale", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Roar", 48256, 59267)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Impale", 48261, 59268)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Roar(_, spellId, _, _, spellName)
	if self.db.profile.roar then
		self:IfMessage(spellName, "Urgent", spellId)
		self:Bar(L["roarcooldown_bar"], 10, spellId)
	end
end

function mod:Impale(player, spellId, _, _, spellName)
	if self.db.profile.impale then
		self:IfMessage(L["impale_message"]:format(spellName, player), "Attention", spellId)
	end
end
