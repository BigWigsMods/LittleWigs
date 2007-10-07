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
	storm = "落雷之雲",
	storm_desc = "施放落雷之雲時發出警報",
	storm_trigger = "享受風暴溫暖的血!",
	storm_message = "落雷之雲！ 注意閃躲！",
} end )

L:RegisterTranslations("frFR", function() return {
	storm = "Nuage d'éclairs",
	storm_desc = "Préviens quand Thespia lance un Nuage d'éclairs.",
	storm_trigger = "Profitez bien de la tempête, sang-tiède !",
	storm_message = "Nuage d'éclairs !",
} end )

L:RegisterTranslations("deDE", function() return {
	storm = "Gewitterwolke",
	storm_desc = "Warnt vor Gewitterwolke",
	storm_trigger = "Genie\195\159t den Sturm, Warmbl\195\188ter!",
	storm_message = "Gewitterwolke!",
} end )

--Chinese Translation: 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
--水术师瑟丝比娅
L:RegisterTranslations("zhCN", function() return {
	storm = "落雷之云",
	storm_desc = "落雷之云发动时发出警报",
	storm_trigger = "享受热血之雨吧！",
	storm_message = "落雷之云!",
} end )

L:RegisterTranslations("esES", function() return {
	storm = "Nube de rel\195\161mpagos",
	storm_desc = "Aviso por Nube de rel\195\161mpagos",
	storm_trigger = "Disfruta de la tormenta, sangre caliente!",
	storm_message = "Nube de rel\195\161mpagos!",
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
