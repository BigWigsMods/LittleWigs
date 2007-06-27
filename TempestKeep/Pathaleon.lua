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
	summon = "召喚虛空幻影",
	summon_desc = "操縱者帕薩里歐召喚虛空幻影時發出警報",
	summon_trigger = "施放了召喚虛空幻影。",
	summon_warn = "虛空幻影已被召喚出來！",

	despawn = "召回虛空幻影",
	despawn_desc = "即將召回虛空幻影時發出警報",
	despawn_warn = "虛空幻影將被召回！",

	despawn_trigger = "我比較喜歡親自動手...",
	despawn_done = "虛空幻影已被召回，帕薩里歐進入狂怒狀態！",

	mc = "支配",
	mc_desc = "支配警報",
	mc_trigger = "^(.+)受到(.*)支配的",
	mc_warn = "%s 受到支配！",
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

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
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
	if ( (time() - summon_time) < 3) then return end
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
	if self.db.profile.despawn and msg:find(L["despawn_trigger"]) then
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
