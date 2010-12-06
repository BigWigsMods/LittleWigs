-- XXX Ulic: Only thing useful I could think of is a timer for when the tornados
-- XXX Ulic: collapse, assuming is consistant, need more logs to find out

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Vizier Ertan", "The Vortex Pinnacle")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43878)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 43878)
end

-------------------------------------------------------------------------------
--  Event Handlers

