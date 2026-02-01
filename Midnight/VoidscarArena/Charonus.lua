--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Charonus", 2923, 2793)
if not mod then return end
mod:SetEncounterID(3287)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1227197, sound = "alert"}, -- Cosmic Blast
	{1248130, sound = "underyou"}, -- Unstable Singularity
	{1264188, sound = "alarm"}, -- Event Horizon
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1227197, "PRIVATE"}, -- Cosmic Blast
		{1248130, "PRIVATE"}, -- Unstable Singularity
		{1264188, "PRIVATE"}, -- Event Horizon
	}
end
