------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Shirrak the Dead Watcher"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Shirrak",

	focus = "Focus Fire",
	focus_desc = "Warn which play is being Focus Fired.",
	focus_message = "%s has Focus Fire",
} end )

L:RegisterTranslations("zhCN", function() return {
	focus = "集中火力",
	focus_desc = "当受到集中火力,警告躲开人群",
	focus_message = "集中活力>%s< 躲开",
} end )

L:RegisterTranslations("koKR", function() return {
	focus = "집중의 불꽃",
	focus_desc = "집중의 불꽃 대상자를 알립니다.",
	focus_message = "%s 집중의 불꽃",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Auchenai Crypts"]
mod.enabletrigger = boss 
mod.toggleoptions = {"focus", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, _, _, player)
	if self.db.profile.focus then
		self:IfMessage(L["focus_message"]:format(player), "Attention", 32300)
	end
end
