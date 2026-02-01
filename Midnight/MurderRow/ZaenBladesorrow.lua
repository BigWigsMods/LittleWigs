--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zaen Bladesorrow", 2813, 2680)
if not mod then return end
mod:SetEncounterID(3102)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{474515, sound = "alert"}, -- Heartstop Poison
	{474545, sound = "warning"}, -- Murder in a Row
	{1214352, sound = "alarm"}, -- Fire Bomb
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{474515, "PRIVATE"}, -- Heartstop Poison
		{474545, "PRIVATE"}, -- Murder in a Row
		{1214352, "PRIVATE"}, -- Fire Bomb
	}
end
