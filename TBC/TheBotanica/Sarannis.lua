------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Commander Sarannis"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Sarannis",
	
	engage_message = "Engaged - spawn four adds in ~60sec!",
	
	summon = "spawn four adds",
	summon_desc = "spawn four adds warnings.",
	summon_warning = "spawn four adds Soon!",
	summon_nextbar = "~Possible spawn four adds",

	resonance = "Arcane Resonance",
	resonance_desc = "Warn for Arcane Resonance",
	resonance_message = "%s is Arcane Resonance!",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_message = "전투 시작 - 약 60초이내 지원군 소환!",
	
	summon = "지원군",
	summon_desc = "지원군 소환에 대해 알립니다.",
	summon_warning = "잠시 후 지원군!",
	summon_nextbar = "~지원군 소환 가능",
	
	resonance = "비전 공명",
	resonance_desc = "비전 공명에 대해 알립니다.",
	resonance_message = "%s 비전 공명!",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_message = "激活 - 约60秒后，召唤4个助手！",
	
	summon = "召唤助手",
	summon_desc = "当召唤助手时发出警报。",
	summon_warning = "即将 召唤助手！",
	summon_nextbar = "<可能 召唤助手>",
	
	resonance = "奥术回响",
	resonance_desc = "当玩家受到奥术回响效果时发出警报。",
	resonance_message = ">%s< 奥术回响！",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_message = "激活 - 約60秒后，召喚4個助手！",
	
	summon = "召喚助手",
	summon_desc = "當召喚助手時發出警報。",
	summon_warning = "即將召喚助手！",
	summon_nextbar = "~可能召喚助手",
	
	resonance = "秘法共鳴",
	resonance_desc = "當玩家受到秘法共鳴效果時發出警報。",
	resonance_message = "秘法共鳴：[%s]！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.guid = 17976
mod.toggleOptions = {"summon", "resonance"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Resonance", 34794)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Resonance(player)
	if self.db.profile.resonance then
		self:IfMessage(L["resonance_message"]:format(player), "Important", 34794)
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.summon then
			self:IfMessage(L["engage_message"], "Attention")
			self:DelayedMessage(55, L["summon_warning"], "Attention")
			self:Bar(L["summon_nextbar"], 60, 37806)
		end
	end
end

