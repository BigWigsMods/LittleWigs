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
} end )

L:RegisterTranslations("koKR", function() return {
	mc = "정신 지배",
	mc_desc = "정신 지배에 대한 경고",
	mc_trigger = "^([^|;%s]*)(.*)지배에 걸렸습니다.$", -- check
	mc_warning = "%s 정신 지배!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"mc", "split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

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
