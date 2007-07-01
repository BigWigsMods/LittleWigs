------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Keli'dan the Breaker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Keli'dan",

	nova = "Burning Nova",
	nova_desc = "Warn for Burning Nova",
	nova_trigger = "Come closer",
	nova_message = "Burning Nova Incoming!",
} end )

L:RegisterTranslations("koKR", function() return {
	nova = "불타는 회오리",
	nova_desc = "불타는 회오리에 대한 경고",
	nova_trigger = "더 가까이", -- check
	nova_message = "불타는 회오리 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	nova = "燃燒新星",
	nova_desc = "破壞者·凱利丹施放燃燒新星時發出警報",
	nova_trigger = "靠近一點!再靠近一點…然後燃燒吧!",
	nova_message = "即將施放燃燒新星！ 迅速離開凱利丹！",
} end )

--Chinese Translation: 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
--击碎者克里丹
L:RegisterTranslations("zhCN", function() return {
	nova = "燃烧新星",
	nova_desc = "施放燃烧新星时发送警报",
	nova_trigger = "Come closer",--check
	nova_message = "燃烧新星 即将发动！ 远离！",

} end )
L:RegisterTranslations("frFR", function() return {
	nova = "Nova ardente",
	nova_desc = "Préviens de l'arrivée des Novas ardentes.",
	nova_trigger = "Approchez",
	nova_message = "Nova ardente imminente !",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.nova and msg:find(L["nova_trigger"]) then
		self:Message(L["nova_message"], "Important")
	end
end
