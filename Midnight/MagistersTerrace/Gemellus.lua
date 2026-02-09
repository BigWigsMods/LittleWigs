--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gemellus", 2811, 2660)
if not mod then return end
mod:SetEncounterID(3073)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1224104, sound = "underyou"}, -- Void Secretions
	{1224401, sound = "alarm"}, -- Cosmic Radiation
	{1284958, sound = "alert"}, -- Cosmic Sting
	{1224299, sound = "warning"}, -- Astral Grasp
	{1253709, sound = "info"}, -- Neural Link
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1224104, "PRIVATE"}, -- Void Secretions
		{1224401, "PRIVATE"}, -- Cosmic Radiation
		{1284958, "PRIVATE"}, -- Cosmic Sting
		{1224299, "PRIVATE"}, -- Astral Grasp
		{1253709, "PRIVATE"}, -- Neural Link
	}
end
