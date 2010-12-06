-- XXX Ulic: Don't recall anything worth reporting on HEROIC

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("General Husam", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(44577)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 44577)
end

-------------------------------------------------------------------------------
--  Event Handlers

