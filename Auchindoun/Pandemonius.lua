------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Pandemonius"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Pandemonius",

	shell = "Dark Shell",
	shell_desc = "Warn when Dark Shell is cast",
	shell_message = "Dark Shell!",
} end )

L:RegisterTranslations("koKR", function() return {
	shell = "암흑의 보호막",
	shell_desc = "암흑의 보호막 시전에 대해 알립니다.",
	shell_message = "암흑의 보호막!",
} end )

L:RegisterTranslations("zhTW", function() return {
	shell = "黑暗之殼",
	shell_desc = "當班提蒙尼厄斯施放黑暗之殼時發出警報",
	shell_message = "黑暗之殼! 停止攻擊!",
} end )

L:RegisterTranslations("frFR", function() return {
	shell = "Cocon de ténèbres",
	shell_desc = "Préviens quand Pandemonius est protégé par son Cocon de ténèbres.",
	shell_message = "Cocon de ténèbres !",
} end )

L:RegisterTranslations("zhCN", function() return {
	shell = "黑暗之壳",
	shell_desc = "当施放黑暗之壳时发出警报。",
	shell_message = "黑暗之壳！停止攻击！",
} end )

L:RegisterTranslations("deDE", function() return {
	shell = "Dunkle H\195\188lle",
	shell_desc = "Warnung wenn Dunkle H\195\188lle gecasted wird",
	shell_message = "Dunkle H\195\188lle!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Mana-Tombs"]
mod.enabletrigger = boss 
mod.toggleoptions = {"shell", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shell", 32358, 38759) -- Normal/Heroic
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Shell(spellId)
	if db.shell then
		self:Message(L["shell_message"], "Attention")
		self:Bar(L["shell_message"], 6, spellId)
	end
end
