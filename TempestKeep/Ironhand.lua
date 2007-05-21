------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Gatewatcher Iron-Hand"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ironhand",

	hammer = "Jackhammer",
	hammer_desc = "Warn when Jackhammer Effect is cast",
	hammer_trigger = "raises his hammer menacingly",
	hammer_warn = "Jackhammer in 3 seconds!",

	shadow = "Shadow Power",
	shadow_desc = "Warn when Iron-Hand gains Shadow Power",
	shadow_trigger = "begins to cast Shadow Power",
	shadow_warn = "Shadow Power in 2 seconds!",
} end )

L:RegisterTranslations("koKR", function() return {
	hammer = "착암기",
	hammer_desc = "착암기 효과 시전 시 경고",
	hammer_trigger = "자신의 망치를 위협적으로 치켜듭니다...", -- check
	hammer_warn = "3초 이내 착암기!",

	shadow = "어둠의 힘",
	shadow_desc = "어둠의 힘을 얻을 시 경고",
	shadow_trigger = "문지기 무쇠주먹|1이;가; 암흑 마법 강화 시전을 시작합니다.", -- check
	shadow_warn = "2초 이내 어둠의 힘!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "看守者",

	hammer = "千斤錘特效",
	hammer_desc = "看守者發動千斤錘特效時發出警報",
	hammer_trigger = "威嚇地舉起他的錘子……",
	hammer_warn = "3 秒後發動千斤錘！ 近戰退後！",

	shadow = "暗影強化",
	shadow_desc = "看守者施放暗影強化時發出警報",
	shadow_trigger = "開始施放暗影強化。",
	shadow_warn = "2 秒後施放暗影強化！",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"hammer", "shadow", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.hammer and msg:find(L["hammer_trigger"]) then
		self:Message(L["hammer_warn"], "Important")
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.shadow and msg:find(L["shadow_trigger"]) then
		self:Message(L["shadow_warn"], "Important")
	end
end
