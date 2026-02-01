--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Seranel Sunlash", 2811, 2661)
if not mod then return end
mod:SetEncounterID(3072)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1225015, sound = "info"}, -- Suppression Zone
	{1225205, sound = "warning"}, -- Wave of Silence
	{1225792, sound = "alert"}, -- Runic Mark
	{1246446, sound = "alarm"}, -- Null Reaction
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1225015, "PRIVATE"}, -- Suppression Zone
		{1225205, "PRIVATE"}, -- Wave of Silence
		{1225792, "PRIVATE"}, -- Runic Mark
		{1246446, "PRIVATE"}, -- Null Reaction
	}
end

