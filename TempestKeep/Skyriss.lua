------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Harbinger Skyriss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local firstSplitAnnounced
local secondSplitAnnounced
local db = nil
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Skyriss",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_trigger = "^([^%s]+) ([^%s]+) afflicted by Domination.$",
	mc_message = "%s is Mind Controlled!",
	mb_bar = "%s - Mind Control",

	split = "Split",
	split_desc = "Warn when Harbinger Skyriss splits",
	split_trigger = "^We span the universe, as countless as the stars!$",
	split_message = "%s has split.",
	split_soon_message = "Split soon!",
	
	mr = "Mind Rend",
	mr_desc = "Warn for Mind Rend",
	mr_trigger = "^([^%s]+) ([^%s]+) afflicted by Mind Rend.$",
	mr_message = "Mind Rend: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	mc = "정신 지배",
	mc_desc = "정신 지배에 대한 경고",
	mc_trigger = "^([^|;%s]*)(.*)지배에 걸렸습니다.",
	mc_message = "%s 정신 지배!",

	split = "분리",
	split_desc = "스키리스 분리 시 경고",
	split_trigger = "밤하늘의 무한한 별처럼 온 우주를 덮으리라!",
	split_message = "%s 분리",
	split_soon_message = "잠시 후 분리!",
	
	mr = "정신 분열",
	mr_desc = "정신 분열에 대한 경고",
	mr_trigger = "^([^|;%s]*)(.*)정신 분열에 걸렸습니다.$",
	mr_message = "정신 분열: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	mc = "Contrôle mental",
	mc_desc = "Préviens quand un joueur est contrôlé.",
	mc_trigger = "^([^%s]+) ([^%s]+) les effets .* Domination.$",
	mc_message = "%s est sous Contrôle mental !",

	split = "Division",
	split_desc = "Préviens quand le Messager Skyriss se divise.",
	split_trigger = "^Nous nous étendons sur l'univers, aussi innombrables que les étoiles !$",
	split_message = "%s s'est divisé.",
	split_soon_message = "Division imminente !",

	mr = "Pourfendre l'esprit",
	mr_desc = "Préviens quand un joueur est affecté par Pourfendre l'esprit.",
	mr_trigger = "^([^%s]+) ([^%s]+) les effets .* Pourfendre l'esprit.$",
	mr_message = "Pourfendre l'esprit : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	mc = "支配",
	mc_desc = "隊友受到支配時發出警報",
	mc_trigger = "^(.+)受(到[了]*)支配效果的影響。$",
	mc_message = "支配: %s",

	split = "分身",
	split_desc = "先驅者史蓋力司施放分身時發出警報",
	split_trigger = "我們跨越宇宙之間，被我們摧毀的世界像星星一樣數不盡!",
	split_message = "%s 分身了，擊殺分身！",
	split_soon_message = "即將分身！",
	
	mr = "心靈撕裂",
	mr_desc = "隊友受到心靈撕裂時發出警報",
	mr_trigger = "^(.+)受(到[了]*)心靈撕裂效果的影響。$",
	mr_message = "心靈撕裂: %s",
} end )

--预言者斯克瑞斯
L:RegisterTranslations("zhCN", function() return {
	mc = "精神控制",
	mc_desc = "精神控制发出警报",
	mc_trigger = "^([^%s]+)受([^%s]+)了支配效果的影响。$",
	mc_message = "精神控制：%s!",

	split = "分身",
	split_desc = "预言者斯克瑞斯分身时发出警报",
	split_trigger = "^我们遍布宇宙的每一个角落，像群星一样无穷无尽！$",
	split_message = "%s 分身！ 击杀.",
	split_soon_message = "即将分身!",
	
	mr = "心灵撕裂",
	mr_desc = "心灵撕裂时发出警报",
	mr_trigger = "^([^%s]+)受([^%s]+)了心灵撕裂效果的影响。$",
	mr_message = "心灵撕裂: %s",
} end )

L:RegisterTranslations("deDE", function() return {
	mc = "Beherrschung",
	mc_desc = "Warnt vor Beherrschung",
	mc_trigger = "^([^%s]+) ([^%s]+) von Beherrschung betroffen.$",
	mc_message = "%s ist \195\188bernommen!",

	split = "Teilung",
	split_desc = "Warnt, wenn der Herold sich teilt",
	split_trigger = "^Das Universum ist unser Zuhause, wir sind zahllos wie die Sterne!$",
	split_message = "%s hat sich geteilt.",
	split_soon_message = "Teilung bald!",
	
	mr = "Gedankenwunde",
	mr_desc = "Warnt vor Gedankenwunde",
	mr_trigger = "^([^%s]+) ([^%s]+) von Gedankenwunde betroffen.$",
	mr_message = "Gedankenwunde: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"mc", "mr", "split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	firstSplitAnnounced = nil
	secondSplitAnnounced = nil

	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "MC", 30923, 35280, 37122, 38626) --These seem the most likely Ids, find the real one
	self:AddCombatListener("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021) --Probably 36924, find the real one
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	
	self:RegisterEvent("UNIT_HEALTH")	
	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "MrEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "MrEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "MrEvent")
	
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MrEvent(msg)
	if not db.mr then return end
	
	local player, type = select(3, msg:find(L["mr_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["mr_message"]:format(player), "Important")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE(msg)
	if not db.mc then return end
	
	local player, type = select(3, msg:find(L["mc_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["mc_message"]:format(player), "Important")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.split and msg == L["split_trigger"] then
		self:Message(L["split_message"]:format(boss), "Urgent")
	end
end

function mod:UNIT_HEALTH(msg)
	if not db.split then return end
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
	if not player or not db.mc then return end
	self:Message(fmt(L["mc_message"], player), "Important")
	self:Bar(fmt(L["mc_bar"], player), 10, spellId) --Double check time once we know exact spellId 
end

function mod:MindRend(player)
	if not db.mr then return end
	self:Message(fmt(L["mr_message"], player), "Important")
end
