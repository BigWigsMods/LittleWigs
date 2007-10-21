------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Wrath-Scryer Soccothrates"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Soccothrates",

	knock = "Knock Away",
	knock_desc = "Warn for Knock Away",
	knock_trigger = "gains Knock Away.$",
	knock_warning = "Knock Away!",
} end )

L:RegisterTranslations("zhTW", function() return {
	knock = "擊退",
	knock_desc = "擊退警報",
	knock_trigger = "獲得了擊退的效果。",
	knock_warning = "近戰被擊退!",
} end )

--天怒预言者苏克拉底
L:RegisterTranslations("zhCN", function() return {
	knock = "击退",
	knock_desc = "击退警报",
	knock_trigger = "获得了击退的效果。$",
	knock_warning = "近战被击退!",
} end )

L:RegisterTranslations("frFR", function() return {
	knock = "Repousser au loin",
	knock_desc = "Préviens quand Soccothrates gagne Repousser au loin.",
	knock_trigger = "gagne Repousser au loin.$",
	knock_warning = "Repousser au loin !",
} end )

L:RegisterTranslations("koKR", function() return {
	knock = "지옥 대포 정렬",
	knock_desc = "지옥 대포 정렬에 대한 경고",
	knock_trigger = "gains Knock Away.$", -- check
	knock_warning = "지옥 대포 정렬!",
} end )

--German Translation: Domestica@Baelgun
L:RegisterTranslations("deDE", function() return {
	knock = "Wegschlagen",
	knock_desc = "Warnt vor dem Wegschlagen",
	knock_trigger = "bekommt 'Wegschlagen'.$",
	knock_warning = "Knockback!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"knock", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")	
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if self.db.profile.knock and msg:find(L["knock_trigger"]) then
		self:Message(L["knock_warning"], "Important")
	end
end
