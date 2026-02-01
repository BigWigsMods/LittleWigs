--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kystia Manaheart", 2813, 2679)
if not mod then return end
mod:SetEncounterID(3101)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1228198, sound = "alert"}, -- Corroding Spittle
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1228198, "PRIVATE"}, -- Corroding Spittle
	}
end
