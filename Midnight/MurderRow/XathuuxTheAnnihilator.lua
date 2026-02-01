--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xathuux the Annihilator", 2813, 2681)
if not mod then return end
mod:SetEncounterID(3103)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{473898, sound = "alarm"}, -- Legion Strike
	{474234, sound = "underyou"}, -- Burning Steps
	{1214650, sound = "alert"}, -- Fel Light
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{473898, "PRIVATE"}, -- Legion Strike
		{474234, "PRIVATE"}, -- Burning Steps
		{1214650, "PRIVATE"}, -- Fel Light
	}
end
