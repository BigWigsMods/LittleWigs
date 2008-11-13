------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Anomalus"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Anomalus",

	rift = "Rift",
	rift_desc = "Warn when Anomalus summons a rift.",
	rift_message = "Rift Summoned",
} end )

L:RegisterTranslations("koKR", function() return {
	rift = "±Õ¿­",
	rift_desc = "¾Æ³ë¸»·ç½ºÀÇ ±Õ¿­ ¼ÒÈ¯À» ¾Ë¸³´Ï´Ù.",
	rift_message = "±Õ¿­ ¼ÒÈ¯!",
} end )

L:RegisterTranslations("frFR", function() return {
	rift = "Faille",
	rift_desc = "Prévient quand Anomalus invoque une faille.",
	rift_message = "Faille invoquée",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	rift = "Раздомы",
	rift_desc = "Предупреждать, когда Anomalus разрывает пространство, создавая хаотический разлом.",
	rift_message = "Разлом создан",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26763
mod.toggleoptions = {"rift", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Rift", 47743)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Rift(_, spellId)
	if self.db.profile.rift then
		self:IfMessage(L["rift_message"], "Important", spellId)
	end
end

