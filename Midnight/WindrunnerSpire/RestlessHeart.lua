--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Restless Heart", 2805, 2658)
if not mod then return end
mod:SetEncounterID(3059)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{468442, sound = "warning"}, -- Billowing Wind
	{472662, sound = "alarm"}, -- Tempest Slash
	{474528, sound = "warning"}, -- Bolt Gale
	{1282911, sound = "warning"}, -- Bolt Gale
	{1216042, sound = "info"}, -- Squall Leap
	{1253979, sound = "warning"}, -- Gust Shot
	{1282955, sound = "underyou"}, -- Storming Soulfont
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{468442, "PRIVATE"}, -- Billowing Wind
		{472662, "PRIVATE"}, -- Tempest Slash
		{474528, "PRIVATE"}, -- Bolt Gale
		{1216042, "PRIVATE"}, -- Squall Leap
		{1253979, "PRIVATE"}, -- Gust Shot
		{1282911, "PRIVATE"}, -- Bolt Gale
		{1282955, "PRIVATE"}, -- Storming Soulfont
	}
end
