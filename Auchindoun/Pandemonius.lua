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
	shell_trigger = "gains Dark Shell",
	shell_message = "Dark Shell!",
} end )

L:RegisterTranslations("koKR", function() return {
	shell = "암흑의 보호막",
	shell_desc = "암흑의 보호막 시전 시 알립니다.",
	shell_trigger = "암흑의 보호막 효과를 얻었습니다.", -- check
	shell_message = "암흑의 보호막!",
} end )

L:RegisterTranslations("zhTW", function() return {
	shell = "黑暗之殼",
	shell_desc = "當班提蒙尼厄斯施放黑暗之殼時發出警報",
	shell_trigger = "獲得了黑暗之殼的效果。",
	shell_message = "黑暗之殼! 停止攻擊!",
} end )

L:RegisterTranslations("frFR", function() return {
	shell = "Cocon de ténèbres",
	shell_desc = "Préviens quand Pandemonius est protégé par son Cocon de ténèbres.",
	shell_trigger = "gagne Cocon de ténèbres",
	shell_message = "Cocon de ténèbres !",
} end )

L:RegisterTranslations("zhCN", function() return {
	shell = "黑暗之壳",
	shell_desc = "黑暗之壳施放警报",
	shell_trigger = "获得了黑暗之壳的效果。$",
	shell_message = "黑暗之壳! 停止攻击",
} end )

L:RegisterTranslations("deDE", function() return {
	shell = "Dunkle H\195\188lle",
	shell_desc = "Warnung wenn Dunkle H\195\188lle gecasted wird",
	shell_trigger = "bekommt 'Dunkle H\195\188lle'.",
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

	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if db.shell and msg:find(L["shell_trigger"]) then
		self:Message(L["shell_message"], "Attention")
		self:Bar(L["shell_message"], 6, "Spell_Shadow_AntiShadow")
	end
end

function mod:Shell(spellId)
	if db.shell then
		self:Message(L["shell_message"], "Attention")
		self:Bar(L["shell_message"], 6, spellId)
	end
end
