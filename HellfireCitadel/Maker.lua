------------------------------
--      Are you local?      --
------------------------------

local boss = BB["The Maker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Maker",

	mc = "Mind Control",
	mc_desc = "Warn for Mind Control",
	mc_message = "%s is Mind Controlled!",
	mc_bar = "%s - Mind Control",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Hellfire Citadel"
mod.zonename = BZ["The Blood Furnace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"mc", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "MC", 30923)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:MC(player, spellId)
	if self.db.profile.mc then
		self:IfMessage(L["mc_message"]:format(player), "Important", spellId)
		self:Bar(L["mc_bar"]:format(player), 10, spellId) 
	end
end
