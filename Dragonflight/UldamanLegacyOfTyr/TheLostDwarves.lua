if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Lost Dwarves", 2451, 2475)
if not mod then return end
--[[mod:RegisterEnableMob(
	-- Baelog
	-- Eric "The Swift"
	-- Olaf
)]]-- TODO correct mob IDs
mod:SetEncounterID(2555)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {

	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

