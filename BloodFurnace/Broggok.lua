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

	poison = "Poison Cloud Alert",
	poison_desc = "Warn for Poison Cloud",
	poison_trigger = "Broggok casts Poison Cloud.",
	poison_message = "Poison Cloud!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
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
