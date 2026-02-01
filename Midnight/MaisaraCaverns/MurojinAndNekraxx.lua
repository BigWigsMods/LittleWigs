--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Muro'jin and Nekraxx", 2874, 2810)
if not mod then return end
mod:SetEncounterID(3212)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1243741, sound = "warning"}, -- Freezing Trap
	{1243752, sound = "underyou"}, -- Icy Slick
	{1246666, sound = "alert"}, -- Infected Pinions
	{1249478, sound = "warning"}, -- Carrion Swoop
	{1260643, sound = "alarm"}, -- Barrage
	{1260709, sound = "alert"}, -- Vilebranch Sting
	{1266488, sound = "alarm"}, -- Open Wound
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1243741, "PRIVATE"}, -- Freezing Trap
		{1243752, "PRIVATE"}, -- Icy Slick
		{1246666, "PRIVATE"}, -- Infected Pinions
		{1249478, "PRIVATE"}, -- Carrion Swoop
		{1260643, "PRIVATE"}, -- Barrage
		{1260709, "PRIVATE"}, -- Vilebranch Sting
		{1266488, "PRIVATE"}, -- Open Wound
	}
end
