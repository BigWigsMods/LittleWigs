------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Blackheart the Inciter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackheart",
	
	engage_message = "Engaged - Incite Chaos in ~15sec!",

	chaos = "Incite Chaos",
	chaos_desc = "Display a bar for the duration of the Incite Chaos",
	chaos_message = "Incite Chaos! Next in ~70sec",
	chaos_warning = "Incite Chaos Soon!",
	chaos_nextbar = "~Possible Incite Chaos",
	
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_message = "战斗开始 - 约15秒后，煽动混乱！",
	
	chaos = "煽动混乱计时条",
	chaos_desc = "显示煽动混乱计时条。",
	chaos_message = "约70秒后，煽动混乱！",
	chaos_warning = "即将 煽动混乱！",
	chaos_nextbar = "<可能 煽动混乱>",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_message = "戰鬥開始 - 15 秒後可能發動煽動混亂!",
	
	chaos = "煽動混亂計時條",
	chaos_desc = "顯示煽動混亂計時條",
	chaos_message = "約 70 秒後，煽動混亂!",
	chaos_warning = "即將 煽動混亂!",
	chaos_nextbar = "<可能 煽動混亂>",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_message = "전투 시작 - 약 15초이내 혼돈 유발!",
	
	chaos = "혼돈 유발",
	chaos_desc = "혼돈 유발의 지속 시간에 대한 바를 표시합니다.",
	chaos_message = "혼돈 유발! 다음은 약 60초 후",
	chaos_warning = "잠시 후 혼돈 유발!",
	chaos_nextbar = "~혼돈 유발 가능",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_message = "Engagé - Provoquer le chaos dans ~15 sec. !",

	chaos = "Provoquer le chaos",
	chaos_desc = "Affiche une barre indiquant la durée de Provoquer le chaos.",
	chaos_message = "Provoquer le chaos ! Prochain dans ~60 sec.",
	chaos_warning = "Provoquer le chaos imminent !",
	chaos_nextbar = "~Provoquer le chaos probable",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"chaos", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Chaos", 33676)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chaos(_, spellId, _, _, spellName)
	if self.db.profile.chaos then
		self:CancelScheduledEvent("chaos")
		self:TriggerEvent("BigWigs_StopBar", self, L["chaos_nextbar"])
		self:IfMessage(L["chaos_message"], "Important", spellID)
		self:Bar(L["chaos"], 15, spellId)
		self:ScheduleEvent("chaos", "BigWigs_Message", 65, L["chaos_warning"], "Urgent", nil, "Alarm")
		self:Bar(L["chaos_nextbar"], 70, spellID)
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.chaos then
			self:IfMessage(L["engage_message"], "Attention")
			self:Bar(L["chaos_nextbar"], 15, 33676)
		end
	end
end
