-- XXX Ulic: Need logs and suggestions
--[[
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ozumat", 767)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42172)
mod.toggleOptions = {
	-- Dark Fissure
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 42172)
end

-------------------------------------------------------------------------------
--  Event Handlers
]]

