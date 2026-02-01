--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lightwarden Ruia", 2859, 2771)
if not mod then return end
mod:SetEncounterID(3201)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1239825, sound = "alarm"}, -- Lightfire
	{1239919, sound = "underyou"}, -- Lightfire Beams
	{1241058, sound = "alarm"}, -- Grievous Thrash
	{1251345, sound = "underyou"}, -- Blight Resin
	{1257094, sound = "alert"}, -- Pulverized
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1239825, "PRIVATE"}, -- Lightfire
		{1239919, "PRIVATE"}, -- Lightfire Beams
		{1241058, "PRIVATE"}, -- Grievous Thrash
		{1251345, "PRIVATE"}, -- Blight Resin
		{1257094, "PRIVATE"}, -- Pulverized
	}
end
