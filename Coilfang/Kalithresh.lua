------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Warlord Kalithresh"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local started = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Kalithresh",
	
	engage_message = "Engaged - channeling in ~15sec!",

	spell = "Spell Reflection",
	spell_desc = "Warn for Spell Reflection",
	spell_message = "Spell Reflection!",

	rage = "Warlord's Rage",
	rage_desc = "Warn for channeling of rage",
	rage_message = "Warlord is channeling!",
	rage_soon = "Channeling Soon",
	rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_message = "開戰 - 15 秒後可能輸送!",
	
	spell = "法術反射",
	spell_desc = "法術反射警報",
	spell_message = "法術反射! 法系停火!",

	rage = "督軍之怒",
	rage_desc = "督軍之怒警報",
	rage_message = "即將發動督軍之怒! 快打蒸餾器!",
	rage_soon = "即將輸送!",
	rage_soonbar = "<可能輸送>",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_message = "Engagé - Canalisation dans ~15 sec. !",

	spell = "Renvoi de sort",
	spell_desc = "Prévient quand Kalithresh renvoye les sorts.",
	spell_message = "Renvoi de sort !",

	rage = "Rage du seigneur de guerre",
	rage_desc = "Prévient quand Kalithresh canalise de la rage.",
	rage_message = "Canalisation en cours !",
	rage_soon = "Canalisation imminente !",
	rage_soonbar = "~Canalisation probable",
} end )

L:RegisterTranslations("deDE", function() return {
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "Zauberreflexion",
	spell_desc = "Warnt vor Zauberreflexion",
	spell_message = "Zauberreflexion!",

	rage = "Zorn des Kriegsf\195\188rsten",
	rage_desc = "Warnt, wenn Kalithresh kanalisiert",
	rage_message = "Kalithresh kanalisiert!",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_message = "전투 시작 - 약 15초이내 채널링!",
	
	spell = "주문 반사",
	spell_desc = "주문 반사에 대한 경고",
	spell_message = "주문 반사!",

	rage = "장군의 분노",
	rage_desc = "분노의 채널링에 대한 알립니다.",
	rage_message = "장군의 분노!",
	rage_soon = "잠시 후 장군의 분노!",
	rage_soonbar = "~장군의 분노 가능",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_message = "开战 - 15秒后，即将传送！",
	
	spell = "法术反射",
	spell_desc = "当法术反射时发出警报。",
	spell_message = "法术反射！",

	rage = "督军之怒",
	rage_desc = "当督军之怒时发出警报。",
	rage_message = "即将 督军之怒！DPS！",
	rage_soon = "即将 传送！",
	rage_soonbar = "<可能传送>",
} end )

L:RegisterTranslations("esES", function() return {
	--engage_message = "Engaged - channeling in ~15sec!",
	
	spell = "Reflejo de Hechizos",
	spell_desc = "Avisa cuando Kalithresh refleja hechizos",
	spell_message = "Reflejo de Hechizos!",

	rage = "Warlord's Rage",
	rage_desc = "Avisa cuando Kalithresh est\195\161 canalizando ira",
	rage_message = "Kalithresh est\195\161 canalizando ira!",
	--rage_soon = "channeling soon!",
	--rage_soonbar = "~Possible channeling",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Steamvault"]
mod.enabletrigger = boss
mod.guid = 17798
mod.toggleoptions = {"spell", "rage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	started = nil
	
	self:AddCombatListener("SPELL_AURA_APPLIED", "Reflection", 31534)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Channel", 31543)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Channel()
	if self.db.profile.rage then
		self:IfMessage(L["rage_message"], "Urgent", 31543)
		self:Bar(L["rage_soonbar"], 40, 31543)
		self:DelayedMessage(35, L["rage_soon"], "Urgent")
	end
end

function mod:Reflection()
	if self.db.profile.spell then
		self:IfMessage(L["spell_message"], "Attention", 31534)
		self:Bar(L["spell"], 8, 31534)
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.rage then
			self:IfMessage(L["engage_message"], "Attention", 31543)
			self:Bar(L["rage_soonbar"], 15, 31543)
		end
	end
end
