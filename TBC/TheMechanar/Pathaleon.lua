------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Pathaleon the Calculator"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local despawnannounced
local summon_time = 0

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Pathaleon",

	summon = "Summoned Wraiths",
	summon_desc = "Warn when Nether Wraiths are summoned",
	summon_message = "Nether Wraiths Summoned!",

	despawn = "Despawned Wraiths",
	despawn_desc = "Warn when Nether Wraiths are about to despawn",
	despawn_message = "Nether Wraiths Despawning Soon!",
	despawn_trigger = "I prefer the direct",
	despawn_trigger2 = "I prefer to be hands",
	despawn_done = "Nether Wraiths despawning!",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_message = "%s is Mind Controlled!",
	mc_bar = "%s - Mind Control",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "망령 소환",
	summon_desc = "황천의 망령 소환에 대해 알립니다.",
	summon_message = "황천의 망령 소환!",

	despawn = "망령 사라짐",
	despawn_desc = "황천의 망령 사라짐에 대해 알립니다.",
	despawn_message = "잠시 후 황천의 망령 사라짐!",
	despawn_trigger = "진짜 싸움을 시작해 볼까...", 
	--despawn_trigger2 = "I prefer to be hands",
	despawn_done = "황천의 망령 사라짐!",

	mc = "정신 지배",
	mc_desc = "정신 지배에 대해 알립니다.",
	mc_message = "%s 정신 지배!",
	mc_bar = "%s - 정신 지배",
} end )

L:RegisterTranslations("zhTW", function() return {
	summon = "召喚虛空怨靈",
	summon_desc = "操縱者帕薩里歐召喚虛空怨靈時發出警報",
	summon_message = "虛空怨靈已被召喚出來！",

	despawn = "召回虛空怨靈",
	despawn_desc = "即將召回虛空怨靈時發出警報",
	despawn_message = "虛空怨靈將被召回！",
	despawn_trigger = "我比較喜歡自己動手做……",
	despawn_trigger2 = "I prefer to be hands",
	despawn_done = "虛空怨靈已被召回，帕薩里歐進入狂怒狀態！",

	mc = "支配",
	mc_desc = "隊友受到支配時發出警報",
	mc_message = "支配: [%s]",
	mc_bar = "支配: [%s]",
} end )

L:RegisterTranslations("zhCN", function() return {
	summon = "虚空怨灵",
	summon_desc = "当召唤虚空怨灵时发出警报。",
	summon_message = "虚空怨灵 出现！",

	despawn = "召回虚空",
	despawn_desc = "当召回虚空怨灵时发出警报。",
	despawn_message = "虚空怨灵召回，帕萨雷恩进入狂暴状态！",
	despawn_trigger = "I prefer the direct",
	despawn_trigger2 = "我喜欢自己动手……",
	despawn_done = "虚空怨灵被召回！进入狂怒状态！",

	mc = "精神控制",
	mc_desc = "当精神控制时发出警报。",
	mc_message = "精神控制：>%s<！",
	mc_bar = "<精神控制：%s>",
} end )

L:RegisterTranslations("frFR", function() return {
	summon = "Âmes en peine invoquées",
	summon_desc = "Prévient quand les âmes en peine du Néant sont invoquées.",
	summon_message = "Âmes en peine du Néant invoquées !",

	despawn = "Âmes en peine disparues",
	despawn_desc = "Prévient quand les âmes en peine du Néant sont sur le point de disparaître.",
	despawn_message = "Disparition des âmes en peine du Néant imminente !",
	despawn_trigger = "Je préfère", -- à vérifier
	despawn_trigger2 = "I prefer to be hands", -- à traduire
	despawn_done = "Âmes en peine du Néant disparues !",

	mc = "Domination",
	mc_desc = "Prévient quand un joueur subit les effets de la Domination.",
	mc_message = "Domination sur %s !",
	mc_bar = "%s - Domination",
} end )

L:RegisterTranslations("deDE", function() return {
	summon = "Beschworene Nethergespenster",
	summon_desc = "Warnt wenn Nethergespenster beschworen werden",
	summon_message = "Nethergespenster beschworen!",

	despawn = "Verschwindende Nethergespenster",
	despawn_desc = "Warnt wenn Nethergespenster kurz davor sind zu verschwinden",
	despawn_message = "Nethergespenster verschwinden bald!",
	despawn_trigger = "Ich mag es lieber praktisch...",
	despawn_done = "Nethergespenster verschwinden!",

	mc = "Gedankenkontrolle",
	mc_desc = "Warnt vor Gedankenkontrolle",
	mc_message = "%s ist \195\188bernommen!",
} end )

L:RegisterTranslations("ruRU", function() return {
	summon = "Призывы Призраков",
	summon_desc = "Предупреждать о призывах Призраков Хаоса",
	summon_message = "Призваны Призраки Хаоса!",

	despawn = "Исчезновение Призраков",
	despawn_desc = "Предупреждать о исчезновении Призраков Хаоса",
	despawn_message = "Скоро Призраки Хаоса исчезнут!",
	despawn_trigger = "I prefer the direct",
	despawn_trigger2 = "I prefer to be hands",
	despawn_done = "Призраки Хаоса исчезли!",

	mc = "Контроль над разумом",
	mc_desc = "Предупреждать о Контроле над разумом",
	mc_message = "%s законтролирован разум!",
	mc_bar = "%s - Контроль над разумом",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss
mod.guid = 19220
mod.toggleOptions = {"summon", "despawn", -1, "mc"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	summon_time = 0
	despawnannounced = nil
	-- There are four spellId's for this summon, and seeing as how I put a time check in
	-- original code I suspect that he casts each of the four spells once, so we only
	-- need to check for one to be cast, the four Ids are 35285, 35286, 35287, 35288
	self:AddCombatListener("SPELL_SUMMON", "Summon", 35285)
	self:AddCombatListener("SPELL_AURA_APPLIED", "MC", 35280)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.despawn and (msg:find(L["despawn_trigger"]) or msg:find(L["despawn_trigger2"])) then
		self:Message(L["despawn_done"], "Important")
	end
end

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.despawn then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 23 and health <= 28 and not despawnannounced then
			despawnannounced = true
			self:Message(L["despawn_message"], "Important")
		elseif health > 30 and despawnannounced then
			despawnannounced = nil
		end
	end
end

function mod:Summon()
	if self.db.profile.summon then
		self:IfMessage(L["summon_message"], "Important", 35285)
	end
end

function mod:MC(player, spellId)
	if self.db.profile.mc then
		self:IfMessage(L["mc_message"]:format(player), "Important", spellId)
		self:Bar(L["mc_bar"]:format(player), 10, spellId) --Double check time once we know exact spellId 
	end
end

