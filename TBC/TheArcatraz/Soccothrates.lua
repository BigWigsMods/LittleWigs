------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Wrath-Scryer Soccothrates"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

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

L:RegisterTranslations("zhCN", function() return {
	knock = "击退",
	knock_desc = "当被击退时发出警报。",
	knock_message = "近战被击退！",
} end )

L:RegisterTranslations("frFR", function() return {
	knock = "Repousser au loin",
	knock_desc = "Prévient quand Soccothrates utilise Repousser au loin.",
	knock_message = "Repousser au loin !",
} end )

L:RegisterTranslations("koKR", function() return {
	knock = "날려버리기",
	knock_desc = "날려버리기에 대해 알립니다.",
	knock_message = "날려버리기!",
} end )

L:RegisterTranslations("deDE", function() return {
	knock = "Wegschlagen",
	knock_desc = "Warnt vor dem Wegschlagen",
	knock_message = "Knockback!",
} end )

L:RegisterTranslations("ruRU", function() return {
	knock = "Отталкивание",
	knock_desc = "Предупреждать о Отталкивании",
	knock_message = "Отталкивание!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Arcatraz"]
mod.enabletrigger = boss 
mod.guid = 20886
mod.toggleOptions = {"knock", "bosskill"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Knock", 36512)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Knock()
	if self.db.profile.knock then
		self:Message(L["knock_message"], "Important")
	end
end

/same
