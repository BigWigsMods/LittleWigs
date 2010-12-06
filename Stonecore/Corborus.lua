-- XXX Ulic: Was easy on normal, need some more logs and experience to see if
-- XXX Ulic: any further warnings are needed, I've heard it's a lot harder on Heroic

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Corborus", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43438)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 43438)
end

-------------------------------------------------------------------------------
--  Event Handlers

