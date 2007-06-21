------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Harbinger Skyriss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local firstSplitAnnounced
local secondSplitAnnounced

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Skyriss",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_trigger = "^([^%s]+) ([^%s]+) afflicted by Domination.$",
	mc_warning = "%s is Mind Controlled!",

	split = "Split",
	split_desc = "Warn when Harbinger Skyriss splits",
	split_trigger = "^We span the universe, as countless as the stars!$",
	split_warning = "%s has split.",
	split_soon_warning = "Split soon!",
	
	mr = "Mind Rend",
	mr_desc = "Warn for Mind Rend",
	mr_trigger = "^([^%s]+) ([^%s]+) afflicted by Mind Rend.$",
	mr_warning = "Mind Rend: %s",
} end )

L:RegisterTranslations("koKR", function() return {
	mc = "정신 지배",
	mc_desc = "정신 지배에 대한 경고",
	mc_trigger = "^([^|;%s]*)(.*)지배에 걸렸습니다.$", -- check
	mc_warning = "%s 정신 지배!",

	split = "분리",
	split_desc = "스키리스 분리 시 경고",
	split_trigger = "^밤하늘의 무한한 별처럼 온 우주를 덮으리라!$", -- check
	split_warning = "%s 분리",
	split_soon_warning = "잠시 후 분리!",
	
	mr = "정신 분열",
	mr_desc = "정신 분열에 대한 경고",
	mr_trigger = "^([^|;%s]*)(.*)정신 분열에 걸렸습니다.$", -- check
	mr_warning = "정신 분열: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	mc = "Contrôle mental",
	mc_desc = "Préviens quand un joueur est contrôlé.",
	mc_trigger = "^([^%s]+) ([^%s]+) les effets .* Domination.$",
	mc_warning = "%s est sous Contrôle mental !",

	split = "Division",
	split_desc = "Préviens quand le Messager Skyriss se divise.",
	split_trigger = "^Nous nous étendons sur l'univers, aussi innombrables que les étoiles !$",
	split_warning = "%s s'est divisé.",
	split_soon_warning = "Division imminente !",

	mr = "Pourfendre l'esprit",
	mr_desc = "Préviens quand un joueur est affecté par Pourfendre l'esprit.",
	mr_trigger = "^([^%s]+) ([^%s]+) les effets .* Pourfendre l'esprit.$",
	mr_warning = "Pourfendre l'esprit : %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	mc = "支配",
	mc_desc = "隊友受到支配時發出警報",
	mc_trigger = "^(.+)受到(.*)支配的傷害。$",
	mc_warning = "%s 被支配了！",

	split = "分身",
	split_desc = "先驅者史蓋力司施放分身時發出警報",
	split_trigger = "^我們跨越宇宙之間，被我們摧毀的世界像星星一樣數不盡!$",
	split_warning = "%s 分身了，擊殺分身！",
	
	mr = "心靈撕裂",
	mr_desc = "隊友受到心靈撕裂時發出警報",
	mr_trigger = "^(.+)受到(.*)心靈撕裂的傷害。$",
	mr_warning = "心靈撕裂: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"mc", "mr", "split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	firstSplitAnnounced = nil
	secondSplitAnnounced = nil
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	
	self:RegisterEvent("UNIT_HEALTH")	
	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "MrEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "MrEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "MrEvent")
	
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MrEvent(msg)
	if not self.db.profile.mr then return end
	
	local player, type = select(3, msg:find(L["mr_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["mr_warning"]:format(player), "Important")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE(msg)
	if not self.db.profile.mc then return end
	
	local player, type = select(3, msg:find(L["mc_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["mc_warning"]:format(player), "Important")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.split and msg == L["split_trigger"] then
		self:Message(L["split_warning"]:format(boss), "Urgent")
	end
end

function mod:UNIT_HEALTH(msg)
	if not self.db.profile.split then return end
	if UnitName(msg) == boss then
		local hp = UnitHealth(msg)
		if hp > 66 and hp < 70 and not firstSplitAnnounced then
			self:Message(L["split_soon_warning"], "Attention")
			firstSplitAnnounced = true
		elseif hp > 33 and hp < 37 and not secondSplitAnnounced then
			self:Message(L["split_soon_warning"], "Attention")
			secondSplitAnnounced = true
		end
	end
end
