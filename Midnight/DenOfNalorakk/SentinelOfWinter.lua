--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sentinel of Winter", 2825, 2777)
if not mod then return end
mod:SetEncounterID(3208)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1235549, sound = "alert"}, -- Glacial Torment
	{1235829, sound = "warning"}, -- Winter's Shroud
	{1235841, sound = "underyou"}, -- Snowdrift
	{1235641, sound = "underyou"}, -- Raging Squall
	{1236289, sound = "underyou"}, -- Blizzard's Wrath
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
    return {
        {1235549, "PRIVATE"}, -- Glacial Torment
        {1235829, "PRIVATE"}, -- Winter's Shroud
        {1235841, "PRIVATE"}, -- Snowdrift
		{1235641, "PRIVATE"}, -- Raging Squall
		{1236289, "PRIVATE"}, -- Blizzard's Wrath
    }
end
