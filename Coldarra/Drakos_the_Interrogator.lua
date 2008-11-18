------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Drakos the Interrogator"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Drakos",

	magicpull = "Magic Pull",
	magicpull_desc = "Announce Magic Pull",
	magicpull_message = "Casting Magic Pull",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
	magicpull = "Traction magique",
	magicpull_desc = "Prévient quand la Traction magique est incantée.",
	magicpull_message = "Traction magique en incantation",
} end )

L:RegisterTranslations("zhTW", function() return {
	magicpull = "魔法拖曳",
	magicpull_desc = "當『審問者』德拉高斯施放魔法拖曳時發出警報。",
	magicpull_message = "正在施放：魔法拖曳！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	magicpull = "魔法牵引",
	magicpull_desc = "当审讯者达库斯施放魔法牵引时发出警报。",
	magicpull_message = "正在施放 魔法牵引！",
} end )

L:RegisterTranslations("ruRU", function() return {
	magicpull = "Магическое притяжение",
	magicpull_desc = "Оповещать о магическом притяжении",
	magicpull_message = "Применяется магическое притяжение",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27654
mod.toggleoptions = {"magicpull", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "MagicPull", 51336)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MagicPull(_, spellId)
	if self.db.profile.magicpull then
		self:IfMessage(L["magicpull_message"], "Important", spellId)
	end
end
