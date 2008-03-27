------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Darkweaver Syth"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Syth",

	summon = "Elementals Alert",
	summon_desc = "Warn for Summoned Elementals",
	summon_message = "Elementals Summoned!",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "정령 알림",
	summon_desc = "정령 소환 시 알립니다.",
	summon_message = "정령 소환!",
} end )

L:RegisterTranslations("zhTW", function() return {
	summon = "召喚元素警報",
	summon_desc = "召喚元素生物時發出警報",
	summon_message = "希斯元素已被召喚出來!",
} end )

L:RegisterTranslations("frFR", function() return {
	summon = "Élémentaires",
	summon_desc = "Préviens quand Syth invoque ses élémentaires.",
	summon_message = "Élémentaires invoqués !",
} end )

L:RegisterTranslations("esES", function() return {
	summon = "Alerta de Elementales",
	summon_desc = "Aviso de Invocaci?n de Elementales",
	summon_message = "Elementales Invocados!",
} end )

L:RegisterTranslations("zhCN", function() return {
	summon = "元素警报",
	summon_desc = "召唤元素警报",
	summon_message = "元素已被召唤!",
} end )

L:RegisterTranslations("deDE", function() return {
	summon = "Elementare-Warnung",
	summon_desc = "Warnt vor beschworenen Elementaren",
	summon_message = "Elementare beschworen!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Sethekk Halls"]
mod.enabletrigger = boss 
mod.toggleoptions = {"summon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Summon", 33538)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Summon()
	if db.summon then
		self:Message(L["summon_message"], "Attention")
	end
end
