------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Blackheart the Inciter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackheart",

	chaos = "Incite Chaos Bar",
	chaos_desc = "Display a bar for the duration of the Incite Chaos",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss 
mod.toggleoptions = {"chaos", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Chaos", 33676)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Chaos(_, spellId, _, _, spellName)
	if self.db.profile.chaos then
		self:Bar(spellName, 15, spellId)
	end
end
