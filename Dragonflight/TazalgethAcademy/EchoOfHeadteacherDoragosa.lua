if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Headteacher Doragosa", 2526, 2513)
if not mod then return end
mod:RegisterEnableMob(189670) -- Echo of Headteacher Doragosa
mod:SetEncounterID(2565)
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

