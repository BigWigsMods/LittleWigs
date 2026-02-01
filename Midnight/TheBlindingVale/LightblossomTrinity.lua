--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lightblossom Trinity", 2859, 2769)
if not mod then return end
mod:SetEncounterID(3199)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1234802, sound = "underyou"}, -- Fertile Loam
	{1235574, sound = "info"}, -- Lightblossom Beam
	{1235828, sound = "underyou"}, -- Light-Scorched Earth
	{1235865, sound = "alert"}, -- Thornblade
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1234802, "PRIVATE"}, -- Fertile Loam
		{1235574, "PRIVATE"}, -- Lightblossom Beam
		{1235828, "PRIVATE"}, -- Light-Scorched Earth
		{1235865, "PRIVATE"}, -- Thornblade
	}
end
