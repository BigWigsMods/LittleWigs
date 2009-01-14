------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Trollgore"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Trollgore",

	wound = "Infected Wound",
	wound_desc = "Warn when some has an Infected Wound.",
	wound_message = "Infected Wound: %s",

	woundBar = "Infected Wound Bar",
	woundBar_desc = "Show a bar for the duration of an Infected Wound.",
} end )

L:RegisterTranslations("koKR", function() return {
	wound = "상처 감염",
	wound_desc = "상처 감염에 걸린 플레이어를 알립니다.",
	wound_message = "상처 감염: %s",

	woundBar = "상처 감염 바",
	woundBar_desc = "상처 감염이 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	wound = "Blessure infectée",
	wound_desc = "Prévient quand un joueur subit les effets de la Blessure infectée.",
	wound_message = "Blessure infectée : %s",

	woundBar = "Blessure infectée - Barre",
	woundBar_desc = "Affiche une barre indiquant la durée de la Blessure infectée.",
} end )

L:RegisterTranslations("zhTW", function() return {
	wound = "感染之傷",
	wound_desc = "當玩家中了感染之傷時發出警報。",
	wound_message = "感染之傷：>%s<！",

	woundBar = "感染之傷計時條",
	woundBar_desc = "當感染之傷持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	wound = "感染之伤",
	wound_desc = "当玩家中了感染之伤时发出警报。",
	wound_message = "感染之伤：>%s<！",

	woundBar = "感染之伤计时条",
	woundBar_desc = "当感染之伤持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	wound = "Зараженные раны",
	wound_desc = "Предупреждать, когда кто-нибудь поражен зараженной раной.",
	wound_message = "Рана: %s",

	woundBar = "Полоса зараженной раны",
	woundBar_desc = "Отображать полосу продолжительности зараженной раны.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 26630
mod.toggleoptions = {"wound", "woundBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Wound", 49637)
	self:AddCombatListener("SPELL_AURA_REMOVED", "WoundRemoved", 49637)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Wound(player, spellId)
	if self.db.profile.wound then
		self:IfMessage(L["wound_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.woundBar then
		self:Bar(L["wound_message"], 10, spellId)
	end
end

function mod:WoundRemoved(player)
	if self.db.profile.woundBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["wound_message"]:format(player))
	end
end
