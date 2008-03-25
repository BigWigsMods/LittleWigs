------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Keli'dan the Breaker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

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
	nova_message = "即將施放燃燒新星! 遠離凱利丹!",
} end )

L:RegisterTranslations("zhCN", function() return {
	nova = "燃烧新星",
	nova_desc = "施放燃烧新星时发送警报",
	nova_trigger = "靠近点！再近点……燃烧吧！",--check
	nova_message = "燃烧新星 即将发动！ 远离！",
} end )

L:RegisterTranslations("frFR", function() return {
	nova = "Nova ardente",
	nova_desc = "Préviens de l'arrivée des Novas ardentes.",
	nova_trigger = "Approchez",
	nova_message = "Nova ardente imminente !",
} end )

L:RegisterTranslations("deDE", function() return {
	nova = "Feuernova",
	nova_desc = "Warnung vor der Feuernova",
	nova_trigger = "Kommt! Kommt n\195\164her... und brennt!",
	nova_message = "Feuernova!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.nova and msg:find(L["nova_trigger"]) then
		self:Message(L["nova_message"], "Important")
	end
end
