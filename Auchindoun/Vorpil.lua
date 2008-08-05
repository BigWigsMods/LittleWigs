------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Grandmaster Vorpil"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local started = nil

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
	
	banish = "Banish (Heroic)",
	banish_desc = "Warn for Banish.",
	banish_message = "%s is Banish!",
	banish_bar = "%s - Banish",
	
	engage_trigger1 = "I'll make an offering of your blood",
	engage_trigger2 = "Good, a worthy sacrifice!",
} end )

L:RegisterTranslations("koKR", function() return {
	teleport = "순간 이동 경고",
	teleport_desc = "순간 이동에 대한 경고",
	teleport_message = "순간 이동!",
	teleport_warning = "약 5초 이내 순간 이동!",
	teleport_bar = "순간 이동",
	
	banish = "추방 (영웅)",
	banish_desc = "추방을 알립니다.",
	banish_message = "%s 추방!",
	banish_bar = "%s - 추방",
	
	engage_trigger1 = "네 피를 제물로 바칠 것이다.",
	engage_trigger2 = "너는 다른 자들에게 좋은 표본이 될 것이다.",
} end )

L:RegisterTranslations("frFR", function() return {
	teleport = "Téléportation",
	teleport_desc = "Prévient quand Vorpil se téléporte avec le groupe.",
	teleport_message = "Téléportation !",
	teleport_warning = "Téléportation dans ~5 sec. !",
	teleport_bar = "Téléportation",

	banish = "Bannir (Héroïque)",
	banish_desc = "Prévient quand un membre du groupe est banni.",
	banish_message = "%s est banni !",
	banish_bar = "%s - Bannir",

	engage_trigger1 = "Je ferai une offrande de ton sang !",
	engage_trigger2 = "Bien, un digne sacrifice !",
} end )

L:RegisterTranslations("zhTW", function() return {
	teleport = "傳送",
	teleport_desc = "領導者瓦皮歐施放傳送時發出警報",
	teleport_message = "傳送! 迅速離開平台!",
	teleport_warning = "5 秒後傳送!",
	teleport_bar = "傳送",
	
	banish = "放逐 (英雄)",
	banish_desc = "放逐警報",
	banish_message = ">%s< 被放逐!",
	banish_bar = "%s - 放逐",

	engage_trigger1 = "你會是其他人很好的榜樣!",
	engage_trigger2 = "很好，一次值得的犧牲!",
} end )

L:RegisterTranslations("deDE", function() return {
	teleport = "Teleport-Warnung",
	teleport_desc = "Warnt vor dem Teleport",
	teleport_message = "Teleport!",
	teleport_warning = "Teleport in ~5sek!",
	teleport_bar = "Teleport",
	
	--banish = "Banish (Heroic)",
	--banish_desc = "Warn for Banish.",
	--banish_message = "%s is Banish!",
	--banish_bar = "%s - Banish",
	
	engage_trigger1 = "I'll make an offering of your blood", --- still needs translation
	engage_trigger2 = "Gut, ein w\195\188rdiges Opfer!",
} end )

L:RegisterTranslations("zhCN", function() return {
	teleport = "传送警告",
	teleport_desc = "当传送时发出警报。",
	teleport_message = "传送！快离开平台！",
	teleport_warning = "5秒后，传送！",
	teleport_bar = "<传送>",
	
	banish = "放逐术（英雄）",
	banish_desc = "当玩家受到放逐术时发出警报。",
	banish_message = ">%s< 被放逐！",
	banish_bar = "<放逐术：%s>",
	
	engage_trigger1 = "我要用你的血当祭品！",
	engage_trigger2 = "很好，一个完美的祭品！",
} end )

L:RegisterTranslations("ruRU", function() return {
	teleport = "Телепорт",
	teleport_desc = "Предупреждение о Телепорте",
	teleport_message = "Телепорт!",
	teleport_warning = "Телепорт в течении ~5сек!",
	teleport_bar = "Телепорт",
	
	banish = "Изгнание (Героик)",
	banish_desc = "Предупреждение о Изгнании.",
	banish_message = "%s Изгнан!",
	banish_bar = "%s - Изгнан",
	
	engage_trigger1 = "I'll make an offering of your blood",
	engage_trigger2 = "Good, a worthy sacrifice!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.guid = 18732
mod.toggleoptions = {"teleport", "banish", "bosskill"}
mod.revision = tonumber(("$Revision: 33724 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	started = nil

	self:AddCombatListener("SPELL_AURA_SUCCESS", "Teleport", 33563)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Banish", 38791)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Teleport()
	if self.db.profile.teleport then
		self:IfMessage(L["teleport_message"], "Urgent", 33563)
		self:Bar(L["teleport_bar"], 37, 33563)
		self:DelayedMessage(32, L["teleport_warning"], "Attention")
	end
end

function mod:Banish(player, spellId)
	if self.db.profile.banish then
		self:IfMessage(L["banish_message"]:format(player), "Important", spellId)
		self:Bar(L["banish_bar"]:format(player), 8, spellId) 
	end
end


function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.teleport then
			self:Bar(L["teleport_bar"], 40, 33563)
			self:DelayedMessage(35, L["teleport_warning"], "Attention", nil, nil, nil, 33563)
		end
	end
end
