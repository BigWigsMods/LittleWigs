------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Mekgineer Steamrigger"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Steamrigger",

	mech = "Steamrigger Mechanics",
	mech_desc = "Warn for incoming mechanics",
	mech_trigger = "Tune 'em up good, boys!",
	mech_message = "Steamrigger Mechanics coming soon!",
} end )

L:RegisterTranslations("koKR", function() return {
	mech = "스팀리거 정비사",
	mech_desc = "스팀리거 정비사 소환 경고",
	mech_trigger = "얘들아, 쟤네들을 부드럽게 만져줘라!",
	mech_message = "잠시 후 스팀리거 정비사 등장!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "米克吉勒·蒸氣操控者",

	mech = "蒸氣操控者技師",
	mech_desc = "呼叫蒸氣操控者技師時發出警報",
	mech_trigger = "好好的修理它們，孩子們!",
	mech_message = "蒸氣操控者技師出現了，恐懼/AE！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Steamvault"]
mod.enabletrigger = boss 
mod.toggleoptions = {"mech", "bosskill"}
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
	if self.db.profile.mech and msg == L["mech_trigger"] then
		self:Message(L["mech_message"], "Attention")
	end
end
