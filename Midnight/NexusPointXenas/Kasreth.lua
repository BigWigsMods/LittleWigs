--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chief Corewright Kasreth", 2915, 2813)
if not mod then return end
mod:SetEncounterID(3328)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1251626, sound = "alarm"}, -- Leyline Array
	{1251772, sound = "alert"}, -- Reflux Charge
	{1257836, sound = "info"}, -- Reflux Charge
	{1264042, sound = "underyou"}, -- Arcane Spill
	{1276485, sound = "alert"}, -- Sparkburn
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1251626, "PRIVATE"}, -- Leyline Array
		{1251772, "PRIVATE"}, -- Reflux Charge
		{1257836, "PRIVATE"}, -- Reflux Charge
		{1264042, "PRIVATE"}, -- Arcane Spill
		{1276485, "PRIVATE"}, -- Sparkburn
	}
end
