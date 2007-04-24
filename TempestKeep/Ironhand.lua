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
	hammer_trigger = "문지기 무쇠주먹이 자신의 망치를 위협적으로 치켜듭니다...", -- check
	hammer_warn = "3초 이내 착암기!",

	shadow = "어둠의 힘",
	shadow_desc = "어둠의 힘을 얻을 시 경고",
	shadow_trigger = "begins to cast Shadow Power", -- check
	shadow_warn = "2초 이내 어둠의 힘!",
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
		self:Message(L["hammer_warn"])
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.shadow and msg:find(L["shadow_trigger"]) then
		self:Message(L["shadow_warn"])
	end
end
