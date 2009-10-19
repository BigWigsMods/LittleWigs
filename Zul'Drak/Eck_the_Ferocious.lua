-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Eck the Ferocious", "Gundrak")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(29932)
mod.toggleOptions = {
	55817, --Residue
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Residue", 55817)
	self:Death("Win", 29932)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Residue(player, spellId, _, _, spellName)
	if player ~= pName then return end
	self:LocalMessage(55817, BCL["you"]:format(spellName), "Positive", spellId, "Info")
end
