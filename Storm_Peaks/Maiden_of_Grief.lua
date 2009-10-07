-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Maiden of Grief", "Halls of Stone")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27975)
mod.toggleOptions = {
	50760, --Shock
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_CAST_START", "Shock", 50760, 59726)
	self:Death("Win", 27975)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shock(_, spellId, _, _, spellName)
	self:Message(50760, L["shock_message"], "Urgent", spellId)
	self:Bar(50760, LCL["casting"]:format(spellName), 4, spellId)
end
