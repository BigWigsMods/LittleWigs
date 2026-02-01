--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Atroxus", 2923, 2792)
if not mod then return end
mod:SetEncounterID(3286)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1222484, sound = "underyou"}, -- Poison Pool
	{1222642, sound = "alarm"}, -- Hulking Claw
	{1226031, sound = "alert"}, -- Poison Splash
	{1263971, sound = "alert"}, -- Lingering Poison
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1222484, "PRIVATE"}, -- Poison Pool
		{1222642, "PRIVATE"}, -- Hulking Claw
		{1226031, "PRIVATE"}, -- Poison Splash
		{1263971, "PRIVATE"}, -- Lingering Poison
	}
end
