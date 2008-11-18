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
	rift = "균열",
	rift_desc = "아노말루스의 균열 소환을 알립니다.",
	rift_message = "균열 소환!",
} end )

L:RegisterTranslations("frFR", function() return {
	rift = "Faille",
	rift_desc = "Prévient quand Anomalus invoque une faille.",
	rift_message = "Faille invoquée",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
	rift = "Riss",
	rift_desc = "Warnt, wenn Anomalus einen Riss beschwört.",
	rift_message = "Riss beschworen",
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
	rift = "Разломы",
	rift_desc = "Предупреждать, когда Аномалус разрывает пространство, создавая хаотический разлом.",
	rift_message = "Разлом открыт!",
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

