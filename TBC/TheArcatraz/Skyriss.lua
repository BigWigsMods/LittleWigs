
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Skyriss", 731, 551)
if not mod then return end
mod:RegisterEnableMob(20912, 20904) -- Harbinger Skyriss, Warden Mellichar

local splitPhase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.split_trigger = "We span the universe, as countless as the stars!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		37162, -- Domination
		36924, -- Mind Rend
		143024, -- Slit, XXX FAKE ID
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Domination", 37162, 39019)
	self:Log("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")

	self:Death("Win", 20912)
end

function mod:OnEngage()
	splitPhase = 1
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Domination(args)
	self:TargetMessage(37162, args.destName, "Urgent")
	self:TargetBar(37162, 6, args.destName)
end

function mod:MindRend(args)
	self:TargetMessage(36924, args.destName, "Important")
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.split_trigger then
		self:Message(143024, "Attention")
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 20912 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if (hp < 71 and splitPhase == 1) or (hp < 36 and splitPhase == 2) then
			splitPhase = splitPhase + 1
			self:Message(143024, "Positive", nil, CL.soon:format(self:SpellName(143024)), false)
			if splitPhase > 2 then
				self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			end
		end
	end
end


--[[
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
]]

