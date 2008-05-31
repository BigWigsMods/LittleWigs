------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Keli'dan the Breaker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Keli'dan",

	nova = "Burning Nova",
	nova_desc = "Warn for Burning Nova",
	nova_message = "Burning Nova Incoming!",
} end )

L:RegisterTranslations("koKR", function() return {
	nova = "불타는 회오리",
	nova_desc = "불타는 회오리에 대해 알립니다.",
	nova_message = "불타는 회오리 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	nova = "燃燒新星",
	nova_desc = "破壞者·凱利丹施放燃燒新星時發出警報",
	nova_message = "即將施放燃燒新星! 遠離凱利丹!",
} end )

L:RegisterTranslations("zhCN", function() return {
	nova = "燃烧新星",
	nova_desc = "当施放燃烧新星时发出警报。",
	nova_message = "燃烧新星 即将发动！ 远离！",
} end )

L:RegisterTranslations("frFR", function() return {
	nova = "Nova ardente",
	nova_desc = "Préviens de l'arrivée des Novas ardentes.",
	nova_message = "Nova ardente imminente !",
} end )

L:RegisterTranslations("deDE", function() return {
	nova = "Feuernova",
	nova_desc = "Warnung vor der Feuernova",
	nova_message = "Feuernova!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"nova", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Nova", 30940)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Nova()
	if self.db.profiel.nova then
		self:IfMessage(L["nova_message"], "Important", 30940)
	end
end
