------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Broggok"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Broggok",

	poison = "Poison Cloud",
	poison_desc = "Warn for Poison Cloud",
	poison_message = "Poison Cloud!",
} end )

L:RegisterTranslations("koKR", function() return {
	poison = "독구름",
	poison_desc = "독구름에 대해 알립니다.",
	poison_message = "독구름!",
} end )

L:RegisterTranslations("zhTW", function() return {
	poison = "毒雲術",
	poison_desc = "布洛克施放毒雲術時發出警報",
	poison_message = "毒雲術! 注意閃避!",
} end )

L:RegisterTranslations("zhCN", function() return {
	poison = "毒云术",
	poison_desc = "当施放毒云术时发出警报。",
	poison_message = "毒云！注意躲避！",
} end )

L:RegisterTranslations("frFR", function() return {
	poison = "Nuage empoisonné",
	poison_desc = "Prévient de l'arrivée des Nuages empoisonnés.",
	poison_message = "Nuage empoisonné !",
} end )

L:RegisterTranslations("deDE", function() return {
	poison = "Giftwolke",
	poison_desc = "Warnt vor der Giftwolke",
	poison_message = "Giftwolke!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"poison", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_DAMAGE", "Cloud", 30916)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Cloud()
	if self.db.profile.poison then
		self:IfMessage(L["poison_message"], "Attention", 30916)
	end
end
