-- XXX Ulic: On normal the fight is easy, any suggestions of useful things?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Slabhide", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43214)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 43214)
end

-------------------------------------------------------------------------------
--  Event Handlers

