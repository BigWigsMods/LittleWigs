------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Svala Sorrowgrave"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local started = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Svala",

	ritual = "Ritual of the Sword",
	ritual_desc = "Warn for the casting of Ritual of the Sword and its cooldown.",

	ritualbars = "Ritual Bars",
	ritualbars_desc = "Show bars for the duration of the Ritual of the Sword and its cooldown.",
	ritualcooldown_message = "Ritual cooldown passed",
	ritualcooldown_bar = "Ritual cooldown",

	preparation = "Ritual Preparation",
	preparation_desc = "Warn who has Ritual Preparation.",
	preparation_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	ritual = "검의 의식",
	ritual_desc = "검의 의식 시전을 알립니다.",

	ritualbars = "검의 의식 바",
	ritualbars_desc = "검의 의식의 지속 바와 재사용 대기시간 바를 표시합니다.",
	ritualcooldown_message = "의식 대기시간 종료",
	ritualcooldown_bar = "의식 대기시간",

	preparation = "검의 의식 대상자",
	preparation_desc = "검의 의식에 걸린 플레이어를 알립니다.",
	preparation_message = "%s: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	ritual = "Rituel de l'Epée",
	ritual_desc = "Prévient quand un Rituel de l'Epée est incanté.",

	ritualbars = "Rituel de l'Epée - Barres",
	ritualbars_desc = "Affiche des barres indiquant la durée du Rituel de l'Epée ainsi que son temps de recharge.",
	ritualcooldown_message = "Temps de recharge du Rituel terminé",
	ritualcooldown_bar = "Recharge Rituel",

	preparation = "Préparation du rituel",
	preparation_desc = "Prévient quand un joueur subit les effets de la Préparation du rituel.",
	preparation_message = "%s : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	ritual = "劍之儀式",
	ritual_desc = "當正在施放劍之儀式或冷卻時發出警報。",

	ritualbars = "劍之儀式計時條",
	ritualbars_desc = "當劍之儀式持續和冷卻時顯示計時條。",
	ritualcooldown_message = "劍之儀式 冷卻結束！",
	ritualcooldown_bar = "<劍之儀式 冷卻>",
	
	preparation = "準備儀式",
	preparation_desc = "當玩家中了準備儀式時發出警報。",
	preparation_message = "%s：>%s<！",
} end )

L:RegisterTranslations("deDE", function() return {

	ritual = "Ritual des Schwertes",
	ritual_desc = "Warnt m wenn das Ritual der Schwerter gewirkt wird.",
	ritualbars = "Ritual",
	ritualbars_desc = "Zeigt Leisten für die Dauer des Rituals der Schwerter und dessen Abklingzeit.",
	ritualcooldown_message = "Abklingzeit des Rituals beendet.",
	ritualcooldown_bar = "Ritual-Abklingzeit",

	preparation = "Vorbereitung des Rituals",
	preparation_desc = "Warnt wer für das Ritual vorbereitet wird.",
	preparation_message = "%s: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	ritual = "利剑仪祭",
	ritual_desc = "当正在施放利剑仪祭或冷却时发出警报。",

	ritualbars = "利剑仪祭计时条",
	ritualbars_desc = "当利剑仪祭持续和冷却时显示计时条。",
	ritualcooldown_message = "利剑仪祭 冷却结束！",
	ritualcooldown_bar = "<利剑仪祭 冷却>",
	
	preparation = "准备仪式",
	preparation_desc = "当玩家中了准备仪式时发出警报。",
	preparation_message = "%s：>%s<！",
} end )

L:RegisterTranslations("ruRU", function() return {
	ritual = "Ритуал меча",
	ritual_desc = "Предупреждать о применении ритуала меча.",

	ritualbars = "Полоса ритуала",
	ritualbars_desc = "Отображает полосу продолжительности ритуала и его перезарядку.",
	ritualcooldown_message = "Перезарядка ритуала закончена!",
	ritualcooldown_bar = "Перезарядка ритуала",

	preparation = "Подготовка ритуала",
	preparation_desc = "Сообщать кого подготовливают к ритуалу.",
	preparation_message = "%s: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26668
mod.toggleoptions = {"ritual", "ritualbars", "preparation", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Ritual", 48276)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Preparation", 48267)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	started = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Ritual(_, spellId, _, _, spellName)
	if self.db.profile.ritual then
		self:IfMessage(L["ritual"], "Urgent", spellId)
		self:DelayedMessage(36, L["ritualcooldown_message"], "Attention")
	end
	if self.db.profile.ritualbars then
		self:Bar(spellName, 26, spellId)
		self:Bar(L["ritualcooldown_bar"], 36, spellId)
	end
end

function mod:Preparation(player, spellId, _, _, spellName)
	if self.db.profile.preparation then
		self:IfMessage(L["preparation_message"]:format(spellName, player), "Attention", spellId)
	end
end
