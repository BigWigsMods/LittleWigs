------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Grandmaster Vorpil"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Vorpil",

	teleport = "Teleport Alert",
	teleport_desc = "Warn for Teleport",
	teleport_message = "Teleport!",
	teleport_warning = "Teleport in ~5sec!",
	teleport_bar = "Teleport",
	
	engage_trigger1 = "I'll make an offering of your blood",
	engage_trigger2 = "Good, a worthy sacrifice!",
} end )

L:RegisterTranslations("koKR", function() return {
	teleport = "순간 이동 경고",
	teleport_desc = "순간 이동에 대한 경고",
	teleport_message = "순간 이동!",
	teleport_warning = "약 5초 이내 순간 이동!",
	teleport_bar = "순간 이동",
	
	engage_trigger1 = "네 피를 제물로 바칠 것이다.",
	engage_trigger2 = "너는 다른 자들에게 좋은 표본이 될 것이다.",
} end )

L:RegisterTranslations("frFR", function() return {
	teleport = "Téléportation",
	teleport_desc = "Préviens quand Vorpil se téléporte avec le groupe.",
	teleport_message = "Téléportation !",
	teleport_warning = "Téléportation dans ~5 sec. !",
	teleport_bar = "Téléportation",

	engage_trigger1 = "Je ferai une offrande de ton sang !",
	engage_trigger2 = "Bien, un digne sacrifice !",
} end )

L:RegisterTranslations("zhTW", function() return {
	teleport = "傳送",
	teleport_desc = "領導者瓦皮歐施放傳送時發出警報",
	teleport_message = "傳送! 迅速離開平台!",
	teleport_warning = "5 秒後傳送!",
	teleport_bar = "傳送",

	engage_trigger1 = "你會是其他人很好的榜樣!",
	engage_trigger2 = "很好，一次值得的犧牲!",
} end )

L:RegisterTranslations("deDE", function() return {
	teleport = "Teleport-Warnung",
	teleport_desc = "Warnt vor dem Teleport",
	teleport_message = "Teleport!",
	teleport_warning = "Teleport in ~5sek!",
	teleport_bar = "Teleport",
	
	engage_trigger1 = "I'll make an offering of your blood", --- still needs translation
	engage_trigger2 = "Gut, ein w\195\188rdiges Opfer!",
} end )

L:RegisterTranslations("zhCN", function() return {
	teleport = "传送警告",
	teleport_desc = "当传送时发出警报。",
	teleport_message = "传送！快离开平台！",
	teleport_warning = "5秒后，传送！",
	teleport_bar = "<传送>",
	
	engage_trigger1 = "我要用你的血当祭品！",
	engage_trigger2 = "很好，一个完美的祭品！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"teleport", "bosskill"}
mod.revision = tonumber(("$Revision: 33724 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Teleport", 33563)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.teleport and (msg:find(L["engage_trigger1"]) or msg == L["engage_trigger2"]) then
		self:Bar(L["teleport_bar"], 40, "Spell_Magic_LesserInvisibilty")
		self:DelayedMessage(35, L["teleport_warning"], "Attention")
	end
end

function mod:Teleport()
	if db.teleport then
		self:Message(L["teleport_message"], "Urgent", nil, "Alert")
		self:Bar(L["teleport_bar"], 37, "Spell_Magic_LesserInvisibilty")
		self:DelayedMessage(32, L["teleport_warning"], "Attention")
	end
end
