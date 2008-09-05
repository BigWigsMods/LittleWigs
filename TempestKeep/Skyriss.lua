------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Harbinger Skyriss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local firstSplitAnnounced = nil
local secondSplitAnnounced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Skyriss",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_message = "%s is Mind Controlled!",
	mc_bar = "%s - Mind Control",

	split = "Split",
	split_desc = "Warn when Harbinger Skyriss splits",
	split_trigger = "^We span the universe, as countless as the stars!$",
	split_message = "%s has split.",
	split_soon_message = "Split soon!",
	
	mr = "Mind Rend",
	mr_desc = "Warn for Mind Rend",
	mr_message = "Mind Rend: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	mc = "정신 지배",
	mc_desc = "정신 지배에 대해 알립니다.",
	mc_message = "%s - 정신 지배!",
	mc_bar = "%s - 정신 지배",

	split = "분리",
	split_desc = "스키리스 분리에 대해 알립니다.",
	split_trigger = "밤하늘의 무한한 별처럼 온 우주를 덮으리라!",
	split_message = "%s 분리",
	split_soon_message = "잠시 후 분리!",
	
	mr = "정신 분열",
	mr_desc = "정신 분열에 대해 알립니다.",
	mr_message = "정신 분열: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	mc = "Domination totale",
	mc_desc = "Prévient quand un joueur subit les effets de la Domination totale.",
	mc_message = "Domination totale sur %s !",

	split = "Division",
	split_desc = "Prévient quand le Messager Skyriss se divise.",
	split_trigger = "^Nous nous étendons sur l'univers, aussi innombrables que les étoiles !$",
	split_message = "%s s'est divisé !",
	split_soon_message = "Division imminente !",

	mr = "Pourfendre l'esprit",
	mr_desc = "Prévient quand un joueur subit les effets de Pourfendre l'esprit.",
	mr_message = "Pourfendre l'esprit sur %s !",
} end )

L:RegisterTranslations("zhTW", function() return {
	mc = "支配",
	mc_desc = "隊友受到支配時發出警報",
	mc_message = "支配: [%s]",

	split = "分身",
	split_desc = "先驅者史蓋力司施放分身時發出警報",
	split_trigger = "我們跨越宇宙之間，被我們摧毀的世界像星星一樣數不盡!",
	split_message = "%s 分身了，擊殺分身!",
	split_soon_message = "即將分身!",
	
	mr = "心靈撕裂",
	mr_desc = "隊友受到心靈撕裂時發出警報",
	mr_message = "心靈撕裂: [%s]",
} end )

L:RegisterTranslations("zhCN", function() return {
	mc = "精神控制",
	mc_desc = "当精神控制时发出警报。",
	mc_message = "精神控制：>%s<！",
	mc_bar = "<精神控制：%s>",

	split = "分身",
	split_desc = "当施放分身时发出警报。",
	split_trigger = "^我们遍布宇宙的每一个角落，像群星一样无穷无尽！$",
	split_message = "%s分身！ 击杀！",
	split_soon_message = "即将分身！",
	
	mr = "心灵撕裂",
	mr_desc = "当施放心灵撕裂时发出警报。",
	mr_message = "心灵撕裂：>%s<！",
} end )

L:RegisterTranslations("deDE", function() return {
	mc = "Beherrschung",
	mc_desc = "Warnt vor Beherrschung",
	mc_message = "%s ist \195\188bernommen!",

	split = "Teilung",
	split_desc = "Warnt, wenn der Herold sich teilt",
	split_trigger = "^Das Universum ist unser Zuhause, wir sind zahllos wie die Sterne!$",
	split_message = "%s hat sich geteilt.",
	split_soon_message = "Teilung bald!",
	
	mr = "Gedankenwunde",
	mr_desc = "Warnt vor Gedankenwunde",
	mr_message = "Gedankenwunde: %s",
} end )

L:RegisterTranslations("ruRU", function() return {
	mc = "Контроль над разумом",
	mc_desc = "Предупреждать о Контроле над разумом",
	mc_message = "%s законтролирован разум!",
	mc_bar = "%s - Контроль над разумом",

	split = "Разделение",
	split_desc = "Предупреждать когда Вестник Скайрис Разделяется",
	split_trigger = "^We span the universe, as countless as the stars!$",
	split_message = "%s Разделенен.",
	split_soon_message = "Надвигается Разделение!",
	
	mr = "Разрыв разума",
	mr_desc = "Предупреждать о Разрыве разума",
	mr_message = "Разрыв разума: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = {boss, BB["Warden Mellichar"]}
mod.guid = 20912
mod.toggleoptions = {"mc", "mr", "split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	firstSplitAnnounced = nil
	secondSplitAnnounced = nil

	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "MC", 37162, 39019)
	self:AddCombatListener("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021)
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")	
	self:RegisterEvent("UNIT_HEALTH")	
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.split and msg == L["split_trigger"] then
		self:Message(L["split_message"]:format(boss), "Urgent")
	end
end

function mod:UNIT_HEALTH(msg)
	if not self.db.profile.split then return end
	if UnitName(msg) == boss then
		local hp = UnitHealth(msg)
		if hp > 66 and hp < 70 and not firstSplitAnnounced then
			self:Message(L["split_soon_message"], "Attention")
			firstSplitAnnounced = true
		elseif hp > 33 and hp < 37 and not secondSplitAnnounced then
			self:Message(L["split_soon_message"], "Attention")
			secondSplitAnnounced = true
		end
	end
end

function mod:MC(player, spellId)
	if self.db.profile.mc then
		self:IfMessage(L["mc_message"]:format(player), "Important", spellId)
		self:Bar(L["mc_bar"]:format(player), 6, spellId)
	end
end

function mod:MindRend(player)
	if self.db.profile.mr then
		self:IfMessage(L["mr_message"]:format(player), "Important", 39017)
	end
end
