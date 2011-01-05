-- XXX Ulic: Don't recall anything worth reporting on HEROIC
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Prophet Barim", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43612)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 43612)
end

-------------------------------------------------------------------------------
--  Event Handlers
]]

