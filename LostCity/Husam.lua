-- XXX Ulic: Don't recall anything worth reporting on HEROIC
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("General Husam", 747)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(44577)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 44577)
end

-------------------------------------------------------------------------------
--  Event Handlers
]]

