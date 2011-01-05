-- XXX Ulic: Need logs and suggestions
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Erunak Stonespeaker", "Throne of the Tides")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40825)
mod.toggleOptions = {
	-- Mind Control
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 40825)
end

-------------------------------------------------------------------------------
--  Event Handlers
]]

