-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rokmar the Crackler", 728, 571)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17991)
mod.toggleOptions = {
	34970, -- Frenzy
	31956, -- Grevious Wound
	"bosskill",
}
mod.optionHeaders = {
	[34970] = "heroic",
	[31956] = "general",
}

-------------------------------------------------------------------------------
--  Locals

local enrageannounced = nil

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Rokmar the Crackler", "enUS", true)
if L then
	--@do-not-package@
	L["enrage_warning"] = "Enraged Soon!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Coilfang/Rokmar", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Rokmar the Crackler")
mod.locale = L

L:RegisterTranslations("deDE", function() return {
	
	throw = "Schreckliche Wunde",
	throw_desc = "Warnt wer von Schreckliche Wunde betroffen ist.",
	throw_message = "Schreckliche Wunde : %s",

	enrage = "Wutanfall (Heroisch)",
	enrage_desc = "Warnt bevor Rokmar einen Wutanfall bekommt",
	enrage_warning = "Wutanfall bald!",
	enrage_message = "Wutanfall!",
} end )

L:RegisterTranslations("frFR", function() return {
	throw = "Blessures graves",
	throw_desc = "Prévient quand un joueur subit les effets des Blessures graves.",
	throw_message = "Blessures graves sur %s !",

	enrage = "Enrager (Héroïque)",
	enrage_desc = "Prévient quand Rokmar est sûr le point de devenir enragé.",
	enrage_warning = "Bientôt enragé !",
	enrage_message = "Enragé !",
} end )

L:RegisterTranslations("koKR", function() return {
	throw = "치명상",
	throw_desc = "치명상에 걸린 플레이어를 알립니다.",
	throw_message = "%s 치명상",
	
	enrage = "격노 (영웅)",
	enrage_desc = "로크마르 격노에 대해 알립니다.",
	enrage_warning = "잠시후 격노!",
	enrage_message = "격노!",
} end )

L:RegisterTranslations("zhCN", function() return {
	throw = "痛苦之伤",
	throw_desc = "当玩家受到痛苦之伤时发出警报。",
	throw_message = "痛苦之伤：>%s<！",
	
	enrage = "激怒（英雄）",
	enrage_desc = "当激怒时发出警报。",
	enrage_warning = "巨钳鲁克玛尔 激怒！",
	enrage_message = "激怒！",
} end )

L:RegisterTranslations("zhTW", function() return {
	throw = "嚴重傷害",
	throw_desc = "隊友受到嚴重傷害時發出警報",
	throw_message = ">%s< 受到嚴重傷害",
	
	enrage = "狂怒（英雄）",
	enrage_desc = "當爆裂者洛克瑪狂怒時發出警報",
	enrage_warning = "即將狂怒!",
	enrage_message = "狂怒!",
} end )

L:RegisterTranslations("ruRU", function() return {
	throw = "Горестная рана",
	throw_desc = "Предупреждать о том каму нанесена горестная рана.",
	throw_message = "Горестная рана нанесена %s'у",

	enrage = "Исступление (Герок)",
	enrage_desc = "Предупреждать о Рокмара Исступлении",
	enrage_warning = "Скоро Исступление!",
	enrage_message = "Исступление!",
} end )

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if GetDungeonDifficulty() == 2 and bit.band(self.db.profile[GetSpellInfo(34970)], BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
		self:RegisterEvent("UNIT_HEALTH")
	end
	self:Log("SPELL_AURA_APPLIED", "Wound", 31956, 38801)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 34970)
	self:Death("Win", 17991)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Wound(player, spellId, _, _, spellName)
	self:TargetMessage(31956, player, spellName, "Urgent", spellId)
end

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(34970, spellName, "Important", spellId)
end

function mod:UNIT_HEALTH(event, msg)
	if UnitName(arg1) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 20 and health <= 25 and not enrageannounced then
		enrageannounced = true
		self:Message(34970, L["enrage_warning"], "Attention")
	elseif health > 28 and enrageannounced then
		enrageannounced = nil
	end
end
