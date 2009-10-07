-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Volkhan", "Halls of Lightning")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(28587)
mod.toggleOptions = {
	52237, -- Stomp
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Stomp", 52237, 59529)
	self:Death("Win", 28587)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Stomp(_, spellId, _, _, spellName)
	self:Message(52237, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(52237, spellName, 3, spellId)
end
