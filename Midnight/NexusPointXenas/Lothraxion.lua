--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lothraxion", 2915, 2815)
if not mod then return end
mod:SetEncounterID(3333)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1255310, sound = "underyou"}, -- Radiant Scar
	{1255335, sound = "alarm"}, -- Searing Rend
	{1255503, sound = "alert"}, -- Brilliant Dispersion
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1255310, "PRIVATE"}, -- Radiant Scar
		{1255335, "PRIVATE"}, -- Searing Rend
		{1255503, "PRIVATE"}, -- Brilliant Dispersion
	}
end
