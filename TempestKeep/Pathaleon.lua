------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Pathaleon the Calculator"]
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
	summon_trigger = "casts Summon Nether Wraith",
	summon_warn = "Nether Wraiths Summoned!",

	despawn = "Despawned Wraiths",
	despawn_desc = "Warn when Nether Wraiths are about to despawn",
	despawn_warn = "Nether Wraiths Despawning Soon!",

	despawn_trigger = "I prefer the direct",
	despawn_trigger2 = "I prefer to be hands",
	despawn_done = "Nether Wraiths despawning!",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_trigger = "^([^%s]+) ([^%s]+) afflicted by Domination.$",
	mc_warn = "%s is Mind Controlled!",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "망령 소환",
	summon_desc = "황천의 망령 소환 시 경고",
	summon_trigger = "철두철미한 파탈리온|1이;가; 황천의 망령 소환|1을;를; 시전합니다.",
	summon_warn = "황천의 망령 소환!",

	despawn = "망령 사라짐",
	despawn_desc = "황천의 망령 사라짐에 대한 알림",
	despawn_warn = "잠시 후 황천의 망령 사라짐!",
	
	despawn_trigger = "진짜 싸움을 시작해 볼까...", 
	despawn_done = "황천의 망령 사라짐!",

	mc = "정신 지배",
	mc_desc = "정신 지배에 대한 경고",
	mc_trigger = "^([^|;%s]*)(.*)지배에 걸렸습니다.$", -- check
	mc_warn = "%s 정신 지배!",
} end )

L:RegisterTranslations("zhTW", function() return {
	summon = "召喚虛空怨靈",
	summon_desc = "操縱者帕薩里歐召喚虛空怨靈時發出警報",
	summon_trigger = "施放了召喚虛空怨靈。",
	summon_warn = "虛空怨靈已被召喚出來！",

	despawn = "召回虛空怨靈",
	despawn_desc = "即將召回虛空怨靈時發出警報",
	despawn_warn = "虛空怨靈將被召回！",

	despawn_trigger = "我比較喜歡自己動手做……",
	despawn_trigger2 = "I prefer to be hands",
	despawn_done = "虛空怨靈已被召回，帕薩里歐進入狂怒狀態！",

	mc = "支配",
	mc_desc = "支配警報",
	mc_trigger = "^(.+)受(到[了]*)支配效果的影響。",
	mc_warn = "%s 受到支配！",
} end )

--计算者帕萨雷恩
L:RegisterTranslations("zhCN", function() return {
	summon = "虚空怨灵",
	summon_desc = "召唤虚空怨灵时发出警报",
	summon_trigger = "施放了虚空怨灵。",
	summon_warn = "虚空怨灵 出现!",

	despawn = "召回虚空",
	despawn_desc = "召回虚空怨灵时发出警报",
	despawn_warn = "虚空怨灵召回， 帕萨雷恩进入狂暴状态!",

	despawn_trigger = "I prefer the direct",
	despawn_trigger2 = "我喜欢自己动手……",
	despawn_done = "虚空怨灵 被召回！ BOSS进入狂怒状态",

	mc = "精神控制",
	mc_desc = "精神控制警报",
	mc_trigger = "^([^%s]+)受([^%s]+)了支配效果的影响。$",
	mc_warn = "精神控制 ：%s!",
} end )

L:RegisterTranslations("frFR", function() return {
	summon = "Âmes en peine invoquées",
	summon_desc = "Préviens quand les âmes en peine du Néant sont invoquées.",
	summon_trigger = "lance Invocation d'une âme en peine du Néant",
	summon_warn = "Âmes en peine du Néant invoquées !",

	despawn = "Âmes en peine disparues",
	despawn_desc = "Préviens quand les âmes en peine du Néant sont sur le point de disparaître.",
	despawn_warn = "Disparition des âmes en peine du Néant imminente !",

	despawn_trigger = "Je préfère", -- à vérifier
	despawn_done = "Âmes en peine du Néant disparues !",

	mc = "Contrôle mental",
	mc_desc = "Préviens quand un joueur est contrôlé.",
	mc_trigger = "^([^%s]+) ([^%s]+) les effets .* Domination.$",
	mc_warn = "%s est sous Contrôle mental !",
} end )

L:RegisterTranslations("deDE", function() return {
	summon = "Beschworene Nethergespenster",
	summon_desc = "Warnt wenn Nethergespenster beschworen werden",
	summon_trigger = "wirkt Nethergespenster beschw\195\182ren",
	summon_warn = "Nethergespenster beschworen!",

	despawn = "Verschwindende Nethergespenster",
	despawn_desc = "Warnt wenn Nethergespenster kurz davor sind zu verschwinden",
	despawn_warn = "Nethergespenster verschwinden bald!",

	despawn_trigger = "Ich mag es lieber praktisch...",
	despawn_done = "Nethergespenster verschwinden!",

	mc = "Gedankenkontrolle",
	mc_desc = "Warnt vor Gedankenkontrolle",
	mc_trigger = "^([^%s]+) ([^%s]+) von Vorherrschaft betroffen.$",
	mc_warn = "%s ist \195\188bernommen!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = {GetAddOnMetadata("LittleWigs_TempestKeep", "X-BigWigs-LoadInZone")} or AceLibrary("AceLocale-2.2"):new("BigWigs_TempestKeep")["The Mechanar"]
mod.otherMenu = GetAddOnMetadata("LittleWigs_TempestKeep", "X-BigWigs-Menu") or AceLibrary("AceLocale-2.2"):new("BigWigs_TempestKeep")["Tempest Keep"]
mod.enabletrigger = boss
mod.toggleoptions = {"summon", "despawn", -1, "mc", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	summon_time = 0
	despawnannounced = nil
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if (time() - summon_time) < 3 then return end
	if self.db.profile.summon and msg:find(L["summon_trigger"]) then
		self:Message(L["summon_warn"], "Important")
		summon_time = time()
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE(msg)
	if not self.db.profile.mc then return end
	local player, type = select(3, msg:find(L["mc_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["mc_warn"]:format(player), "Important")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.despawn and (msg:find(L["despawn_trigger"]) or msg:find(L["despawn_trigger2"])) then
		self:Message(L["despawn_done"], "Important")
	end
end

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.despawn then return end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 20 and health <= 25 and not despawnannounced then
			despawnannounced = true
			self:Message(L["despawn_warn"], "Important")
		elseif health > 30 and despawnannounced then
			despawnannounced = nil
		end
	end
end

