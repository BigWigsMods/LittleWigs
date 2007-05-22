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
	poison_trigger = "브로고크|1이;가; 독구름|1을;를; 시전합니다.", -- check
	poison_message = "독구름!",
} end )

L:RegisterTranslations("zhTW", function() return {
	cmd = "布洛克",

	poison = "Poison Cloud",
	poison_desc = "Warn for Poison Cloud",
	poison_trigger = "Broggok casts Poison Cloud.",
	poison_message = "Poison Cloud!",
} end )

L:RegisterTranslations("frFR", function() return {
	poison = "Nuage empoisonné",
	poison_desc = "Préviens de l'arrivée des Nuages empoisonnés.",
	poison_trigger = "Broggok lance Nuage empoisonné.",
	poison_message = "Nuage empoisonné !",
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
