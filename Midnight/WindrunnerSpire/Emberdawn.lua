--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Emberdawn", 2805, 2655)
if not mod then return end
mod:SetEncounterID(3056)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{466091, sound = "alarm"}, -- Searing Beak
	{466559, sound = "warning"}, -- Flaming Updraft
	{470212, sound = "warning"}, -- Flaming Twisters
	{472118, sound = "underyou"}, -- Ignited Embers
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{466091, "PRIVATE"}, -- Searing Beak
		{466559, "PRIVATE"}, -- Flaming Updraft
		{470212, "PRIVATE"}, -- Flaming Twisters
		{472118, "PRIVATE"}, -- Ignited Embers
	}
end
