------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Warp Splinter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Splinter",
	
	engage_message = "Engaged - Spawn Treants in ~15sec!",

	treants = "Treants",
	treants_desc = "Spawn Treants warnings.",
	treants_message = "Spawn Treants! Next in ~45sec",
	treants_warning = "Spawn Treants Soon!",
	treants_nextbar = "~Possible Spawn Treants",
	
} end )

L:RegisterTranslations("koKR", function() return {
	engage_message = "전투 시작 - 약 15초이내 나무 정령 소환!",
	
	treants = "나무 정령",
	treants_desc = "나무 정령 소환을 알립니다.",
	treants_message = "나무 정령 소환! 다음은 약 45초 후",
	treants_warning = "잠시 후 나무 정령 소환!",
	treants_nextbar = "~나무 정령 소환 가능",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_message = "激活 - 约15秒后，召唤树苗！",
	
	treants = "召唤树苗",
	treants_desc = "当召唤树苗时发出警报。",
	treants_message = "约45秒后，召唤树苗！",
	treants_warning = "即将 召唤树苗！",
	treants_nextbar = "<可能 召唤树苗>",

} end )

L:RegisterTranslations("zhTW", function() return {
	engage_message = "激活 - 約15秒后，召喚樹苗！",
	
	treants = "召喚樹苗",
	treants_desc = "當召喚樹苗時發出警報。",
	treants_message = "約45秒后，召喚樹苗！",
	treants_warning = "即將召喚樹苗！",
	treants_nextbar = "~可能召喚樹苗",

} end )
----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.guid = 17977
mod.toggleOptions = {"treants"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_SUMMON", "Treants", 34727)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

local last = 0
function mod:Treants(_, spellID)
	local time = GetTime()
	if (time - last) > 5 then
		last = time
		if self.db.profile.treants then
			self:CancelScheduledEvent("treants")
			self:TriggerEvent("BigWigs_StopBar", self, L["treants_nextbar"])
			self:IfMessage(L["treants_message"], "Important", spellID)
			self:Bar(L["treants"], 20, spellId)
			self:ScheduleEvent("treants", "BigWigs_Message", 40, L["treants_warning"], "Attention", nil, "Alarm")
			self:Bar(L["treants_nextbar"], 45, spellID)
		end
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.treants then
			self:IfMessage(L["engage_message"], "Attention")
			self:Bar(L["treants_nextbar"], 15, 34727)
		end
	end
end

