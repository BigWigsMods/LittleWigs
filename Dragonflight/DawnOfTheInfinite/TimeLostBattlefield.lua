if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Time-Lost Battlefield", 2579, UnitFactionGroup("player") == "Horde" and 2534 or 2533)
if not mod then return end
mod:RegisterEnableMob() -- Anduin Lothar, Grommash Hellscream
mod:SetEncounterID(2672)
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

