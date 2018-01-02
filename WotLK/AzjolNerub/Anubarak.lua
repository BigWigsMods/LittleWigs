-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Anub'arakAN", 533) -- AN (AnzolNerub) is intentional to prevent conflict with Anub'arak from The Coliseum
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.displayName = "Anub'arak"
mod:RegisterEnableMob(29120)
mod.toggleOptions = {
	53472, -- Pound
}

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Pound", 53472, 59433)
	self:Death("Win", 29120)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Pound(_, spellId, _, _, spellName)
	self:Bar(53472, spellName, 3.2, spellId)
	self:Message(53472, LCL["casting"]:format(spellName), "Attention", spellId)
end
