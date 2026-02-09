--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Kroluk", 2805, 2657)
if not mod then return end
mod:SetEncounterID(3058)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{467620, sound = "alarm"}, -- Rampage
	{468659, sound = "alert"}, -- Throw Axe
	{470966, sound = "warning"}, -- Bladestorm
	{468924, sound = "underyou"}, -- Bladestorm
	{1283247, sound = "alarm"}, -- Reckless Leap
	{472054, sound = "none"}, -- Reckless Leap
	{1253030, sound = "warning"}, -- Intimidating Shout
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{467620, "PRIVATE"}, -- Rampage
		{468659, "PRIVATE"}, -- Throw Axe
		{470966, "PRIVATE"}, -- Bladestorm
		{468924, "PRIVATE"}, -- Bladestorm
		{1283247, "PRIVATE"}, -- Reckless Leap
		{472054, "PRIVATE"}, -- Reckless Leap
		{1253030, "PRIVATE"}, -- Intimidating Shout
	}
end
