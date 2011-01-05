-- XXX Ulic: Need logs and suggestions
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Commander Ulthok", "Throne of the Tides")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40765)
mod.toggleOptions = {
	-- Dark Fissure
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 40765)
end

-------------------------------------------------------------------------------
--  Event Handlers
]]

