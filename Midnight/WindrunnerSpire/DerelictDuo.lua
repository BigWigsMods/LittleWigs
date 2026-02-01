--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Derelict Duo", 2805, 2656)
if not mod then return end
mod:SetEncounterID(3057)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{472777, sound = "underyou"}, -- Gunk Splatter
	{472793, sound = "warning"}, -- Heaving Yank
	{472888, sound = "alarm"}, -- Bone Hack
	{474129, sound = "alarm"}, -- Splattering Spew
	{1253834, sound = "info"}, -- Curse of Darkness
	{1215803, sound = "alarm"}, -- Curse of Darkness
	{1219491, sound = "long"}, -- Debilitating Shriek
	{1282272, sound = "alert"}, -- Splattered
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{472777, "PRIVATE"}, -- Gunk Splatter
		{472793, "PRIVATE"}, -- Heaving Yank
		{472888, "PRIVATE"}, -- Bone Hack
		{474129, "PRIVATE"}, -- Splattering Spew
		{1215803, "PRIVATE"}, -- Curse of Darkness
		{1219491, "PRIVATE"}, -- Debilitating Shriek
		{1253834, "PRIVATE"}, -- Curse of Darkness
		{1282272, "PRIVATE"}, -- Splattered
	}
end
