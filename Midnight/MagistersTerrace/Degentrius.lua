--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Degentrius", 2811, 2662)
if not mod then return end
mod:SetEncounterID(3074)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1215157, sound = "alarm"}, -- Unstable Void Essence
	{1215161, sound = "alert"}, -- Void Destruction
	{1215897, sound = "warning"}, -- Devouring Entropy
	{1269631, sound = "alert"}, -- Entropy Orb
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1215157, "PRIVATE"}, -- Unstable Void Essence
		{1215161, "PRIVATE"}, -- Void Destruction
		{1215897, "PRIVATE"}, -- Devouring Entropy
		{1269631, "PRIVATE"}, -- Entropy Orb
	}
end
