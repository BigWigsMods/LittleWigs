------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Selin Fireheart"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Selin",

	channel = "Channel Mana",
	channel_desc = "Warn when Selin Fireheart is channeling mana from a Fel Crystal",
	channel_message = "Channeling Mana!",
	channel_trigger = "channel from the nearby Fel Crystal",
} end )

L:RegisterTranslations("koKR", function() return {
	channel = "분노의 마나",
	channel_desc = "셀린 파이어하트가 지옥 수정에서 마력 흡수에 대해 알립니다.",
	channel_message = "분노의 마나!",
	channel_trigger = "근처의 지옥 수정에서 힘을 끌어냅니다...",
} end )

L:RegisterTranslations("frFR", function() return {
	channel = "Canalise du mana",
	channel_desc = "Prévient quand Selin Coeur-de-feu canalise du mana à partir d'un gangrecristal.",
	channel_message = "Canalise du mana !",
	channel_trigger = "commence à canaliser l'énergie du gangrecristal tout proche…",
} end )

L:RegisterTranslations("zhCN", function() return {
	channel = "法力通道",
	channel_desc = "当从魔能水晶获取法力时发出警报。",
	channel_message = "法力通道！",
	channel_trigger = "开始吸取附近魔能水晶的能量……",
} end )

L:RegisterTranslations("zhTW", function() return {
	channel = "法力通道",
	channel_desc = "當賽林·炎心以魔能水晶獲取法力時發出警報",
	channel_message = "法力通道!",
	channel_trigger = "從附近的惡魔水晶進行導引……",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"channel","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE","Channel")

	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Channel(msg)
	if db.channel and msg:find(L["channel_trigger"]) then
		self:Message(L["channel_message"], "Important")
	end
end
