--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rak'tul, Vessel of Souls", 2874, 2812)
if not mod then return end
mod:SetEncounterID(3214)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1251023, sound = "alarm"}, -- Spiritbreaker
	{1252675, sound = "alarm"}, -- Crush Souls
	{1252777, sound = "alert"}, -- Soulbind
	{1252816, sound = "underyou"}, -- Chill of Death
	{1253779, sound = "underyou"}, -- Spectral Decay
	{1253844, sound = "info"}, -- Withering Soul
	{1254043, sound = "alarm"}, -- Eternal Suffering
	{1254175, sound = "alarm"}, -- Cries of the Fallen
	{1255629, sound = "info"}, -- Spectral Residue
	{1266188, sound = "alarm"}, -- Shadow Realm
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1251023, "PRIVATE"}, -- Spiritbreaker
		{1252675, "PRIVATE"}, -- Crush Souls
		{1252777, "PRIVATE"}, -- Soulbind
		{1252816, "PRIVATE"}, -- Chill of Death
		{1253779, "PRIVATE"}, -- Spectral Decay
		{1253844, "PRIVATE"}, -- Withering Soul
		{1254043, "PRIVATE"}, -- Eternal Suffering
		{1254175, "PRIVATE"}, -- Cries of the Fallen
		{1255629, "PRIVATE"}, -- Spectral Residue
		{1266188, "PRIVATE"}, -- Shadow Realm
	}
end
