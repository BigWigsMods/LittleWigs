------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Broggok"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Broggok",

	poison = "Poison Cloud",
	poison_desc = "Warn for Poison Cloud",
	poison_trigger = "Broggok casts Poison Cloud.",
	poison_message = "Poison Cloud!",
} end )

L:RegisterTranslations("koKR", function() return {
	poison = "독구름",
	poison_desc = "독구름 경고",
	poison_trigger = "브로고크|1이;가; 독 구름|1을;를; 시전합니다.",
	poison_message = "독구름!",
} end )

L:RegisterTranslations("zhTW", function() return {
	poison = "毒雲術",
	poison_desc = "布洛克施放毒雲術時發出警報",
	poison_trigger = "^布洛克施放了毒雲術。",
	poison_message = "毒雲術! 注意閃避!",
} end )

--Chinese Translation: 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
--布洛戈克
L:RegisterTranslations("zhCN", function() return {
	poison = "毒云术",
	poison_desc = "施放毒云术发出警报",

	poison_trigger = "布洛戈克施放了毒云。",
	poison_message = "毒云术！注意躲避！",

} end )
L:RegisterTranslations("frFR", function() return {
	poison = "Nuage empoisonné",
	poison_desc = "Préviens de l'arrivée des Nuages empoisonnés.",
	poison_trigger = "Broggok lance Nuage empoisonné.",
	poison_message = "Nuage empoisonné !",
} end )

--German Translation: Domestica@Baelgun
L:RegisterTranslations("deDE", function() return {
   poison = "Giftwolke",
   poison_desc = "Warnt vor der Giftwolke",
   poison_trigger = "Broggok wirkt Giftwolke.",
   poison_message = "Giftwolke!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"poison", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE(msg)
	if self.db.profile.poison and msg == L["poison_trigger"] then
		self:Message(L["poison_message"], "Attention")
	end
end
