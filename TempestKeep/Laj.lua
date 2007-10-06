------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Laj"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Laj",

	allergic = "Allergic Reaction",
	allergic_desc = "Warn for Allergic Reaction",
	allergic_trigger = "^([^%s]+) ([^%s]+) afflicted by Allergic Reaction",
	allergic_warn = "%s is Allergic!",
} end )

L:RegisterTranslations("koKR", function() return {
	allergic = "알레르기 반응",
	allergic_desc = "알레르기 반응에 대한 알림",
	allergic_trigger = "^([^|;%s]*)(.*)알레르기 반응에 걸렸습니다%.$",
	allergic_warn = "%s 알레르기!",
} end )

L:RegisterTranslations("zhTW", function() return {
	allergic = "過敏反應",
	allergic_desc = "過敏反應警報",
	allergic_trigger = "^(.+)受到(.*)過敏反應效果的影響。",
	allergic_warn = "過敏反應: %s！",
} end )

--拉伊
L:RegisterTranslations("zhCN", function() return {
	allergic = "过敏反应",
	allergic_desc = "过敏反应警告",
	allergic_trigger = "^(.+)受(.+)了过敏反应效果的影响。",
	allergic_warn = "过敏反应： %s！",
} end )

L:RegisterTranslations("frFR", function() return {
	allergic = "Réaction allergique",
	allergic_desc = "Préviens quand un joueur fait une Réaction allergique.",
	allergic_trigger = "^([^%s]+) ([^%s]+) les effets .* Réaction allergique",
	allergic_warn = "%s est allergique !",
} end )

L:RegisterTranslations("deDE", function() return {
	allergic = "Allergische Reaktion",
	allergic_desc = "Warnt vor Allergischer Reaktion",
	allergic_trigger = "^([^%s]+) ([^%s]+) von Allergische Reaktion betroffen.",
	allergic_warn = "%s ist allergisch!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Botanica"]
mod.enabletrigger = boss 
mod.toggleoptions = {"allergic", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "CheckAllergic")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "CheckAllergic")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "CheckAllergic")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CheckAllergic(msg)
	if not self.db.profile.allergic then return end
	local player, type = select(3, msg:find(L["allergic_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		if self.db.profile.allergic then self:Message(L["allergic_warn"]:format(player), "Important") end
	end
end
