-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Erekem", "The Violet Hold")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29315, 32226)
mod.toggleOptions = {
	54481, -- Chain Heal
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainHeal", 54481, 59473)
	self:Death("Win", 29315, 32226)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ChainHeal(_, spellId, _, _, spellName)
	self:Message(54481, LCL["casting"]:format(spellName), "Urgent", spellId)
end
