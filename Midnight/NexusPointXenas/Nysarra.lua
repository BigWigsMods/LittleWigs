--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Corewarden Nysarra", 2915, 2814)
if not mod then return end
mod:SetEncounterID(3332)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1247975, sound = "info"}, -- Lightscar Flare
	{1249020, sound = "alarm"}, -- Eclipsing Step
	{1252828, sound = "alarm"}, -- Void Gash
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1247975, "PRIVATE"}, -- Lightscar Flare
		{1249020, "PRIVATE"}, -- Eclipsing Step
		{1252828, "PRIVATE"}, -- Void Gash
	}
end
