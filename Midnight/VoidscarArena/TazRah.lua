--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taz'Rah", 2923, 2791)
if not mod then return end
mod:SetEncounterID(3285)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1222103, sound = "alert"}, -- Nether Dash
	{1262283, sound = "long"}, -- Dark Rift
	{1222305, sound = "underyou"}, -- Dark Rift
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1222103, "PRIVATE"}, -- Nether Dash
		{1262283, "PRIVATE"}, -- Dark Rift
		{1222305, "PRIVATE"}, -- Dark Rift
	}
end
