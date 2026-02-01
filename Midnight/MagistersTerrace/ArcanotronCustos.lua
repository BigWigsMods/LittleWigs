--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Arcanotron Custos", 2811, 2659)
if not mod then return end
mod:SetEncounterID(3071)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1214038, sound = "alarm"}, -- Ethereal Shackles
	{1214089, sound = "underyou"}, -- Arcane Residue
	{1243905, sound = "warning"}, -- Unstable Energy
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1214038, "PRIVATE"}, -- Ethereal Shackles
		{1214089, "PRIVATE"}, -- Arcane Residue
		{1243905, "PRIVATE"}, -- Unstable Energy
	}
end
