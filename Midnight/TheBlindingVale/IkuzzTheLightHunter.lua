--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ikuzz the Light Hunter", 2859, 2770)
if not mod then return end
mod:SetEncounterID(3200)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1237091, sound = "warning"}, -- Bloodthirsty Gaze
	{1237267, sound = "alarm"}, -- Incise
	{1272290, sound = "warning"}, -- Crunched
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1237091, "PRIVATE"}, -- Bloodthirsty Gaze
		{1237267, "PRIVATE"}, -- Incise
		{1272290, "PRIVATE"}, -- Crunched
	}
end
