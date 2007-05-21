------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Hydromancer Thespia"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Thespia",

	storm = "Lightning Cloud",
	storm_desc = "Warn for Lightning Cloud",
	storm_trigger = "Enjoy the storm warm bloods!",
	storm_message = "Lightning Cloud!",
} end )

L:RegisterTranslations("koKR", function() return {
        storm = "먹구름",
	storm_desc = "먹구름에 대한 경고",
	storm_trigger = "피를 끓게 하는 폭풍의 힘을 즐겨라!",
	storm_message = "먹구름!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "海法師希斯比亞",

	storm = "落雷之雲",
	storm_desc = "施放落雷之雲時發出警報",
	storm_trigger = "享受風暴溫暖的血!",
	storm_message = "落雷之雲！ 注意閃躲！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Steamvault"]
mod.enabletrigger = boss 
mod.toggleoptions = {"storm", "bosskill"}
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
	if self.db.profile.storm and msg == L["storm_trigger"] then
		self:Message(L["storm_message"], "Attention")
	end
end
