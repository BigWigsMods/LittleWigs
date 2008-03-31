------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Wrath-Scryer Soccothrates"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Soccothrates",

	knock = "Knock Away",
	knock_desc = "Warn for Knock Away",
	knock_message = "Knock Away!",
} end )

L:RegisterTranslations("zhTW", function() return {
	knock = "擊退",
	knock_desc = "擊退警報",
	knock_message = "近戰被擊退!",
} end )

--天怒预言者苏克拉底
L:RegisterTranslations("zhCN", function() return {
	knock = "击退",
	knock_desc = "击退警报",
	knock_message = "近战被击退!",
} end )

L:RegisterTranslations("frFR", function() return {
	knock = "Repousser au loin",
	knock_desc = "Préviens quand Soccothrates gagne Repousser au loin.",
	knock_message = "Repousser au loin !",
} end )

L:RegisterTranslations("koKR", function() return {
	knock = "지옥 대포 정렬",
	knock_desc = "지옥 대포 정렬에 대해 알립니다.",
	knock_message = "지옥 대포 정렬!",
} end )

L:RegisterTranslations("deDE", function() return {
	knock = "Wegschlagen",
	knock_desc = "Warnt vor dem Wegschlagen",
	knock_message = "Knockback!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"knock", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- There are about a bazillion Knock Away spells on wowhead, need to find the right one
	--self:AddCombatListener("SPELL_CAST_START", "Knock", #####)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Knock()
	if db.knock then
		self:Message(L["knock_message"], "Important")
	end
end
