--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ziekett", 2859, 2772)
if not mod then return end
mod:SetEncounterID(3202)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1246751, sound = "warning"}, -- Concentrated Lightbeam
	{1246753, sound = "underyou"}, -- Lightsap
	{1247746, sound = "alarm"}, -- Thornspike
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1246751, "PRIVATE"}, -- Concentrated Lightbeam
		{1246753, "PRIVATE"}, -- Lightsap
		{1247746, "PRIVATE"}, -- Thornspike
	}
end
