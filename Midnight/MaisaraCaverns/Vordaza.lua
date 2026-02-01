--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vordaza", 2874, 2811)
if not mod then return end
mod:SetEncounterID(3213)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1251568, sound = "alert"}, -- Drain Soul
	{1251775, sound = "warning"}, -- Final Pursuit
	{1251813, sound = "info"}, -- Lingering Dread
	{1251833, sound = "underyou"}, -- Soulrot
	{1252130, sound = "alarm"}, -- Unmake
	{1266706, sound = "info"}, -- Haunting Remains
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1251568, "PRIVATE"}, -- Drain Soul
		{1251775, "PRIVATE"}, -- Final Pursuit
		{1251813, "PRIVATE"}, -- Lingering Dread
		{1251833, "PRIVATE"}, -- Soulrot
		{1252130, "PRIVATE"}, -- Unmake
		{1266706, "PRIVATE"}, -- Haunting Remains
	}
end
