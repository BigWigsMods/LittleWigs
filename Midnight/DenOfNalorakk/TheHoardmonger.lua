--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Hoardmonger", 2825, 2776)
if not mod then return end
mod:SetEncounterID(3207)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1234846, sound = "info"}, -- Toxic Spores
	{1235125, sound = "alarm"}, -- Hearty Bellow
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
    return {
        {1234846, "PRIVATE"}, -- Toxic Spores
        {1235125, "PRIVATE"}, -- Hearty Bellow
    }
end
