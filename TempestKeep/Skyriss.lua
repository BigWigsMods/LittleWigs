------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Harbinger Skyriss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

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

	mr = "Pourfendre l'esprit",
	mr_desc = "Préviens quand un joueur est affecté par Pourfendre l'esprit.",
	mr_trigger = "^([^%s]+) ([^%s]+) les effets .* Pourfendre l'esprit.$",
	mr_warning = "Pourfendre l'esprit : %s",
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
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	
	
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
