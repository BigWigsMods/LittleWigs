--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidscar Arena Trash", 2923)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	[1267894] = {soundOnApplied = "none"}, -- Savage Leap
	[1299913] = {soundOnApplied = "none"}, -- Null Eruption
	[1250043] = {soundOnApplied = "none"}, -- Melt Armor
	[1234833] = {soundOnApplied = "none"}, -- Ravenous Swarm
	[1249712] = {soundOnApplied = "none"}, -- Venomous Spit
	[1233535] = {soundOnApplied = "none"}, -- Shred Defense
	[1300138] = {soundOnApplied = "none"}, -- Void Beam
	[1252406] = {soundOnApplied = "none"}, -- Dreadbellow
	[1300243] = {soundOnApplied = "none"}, -- Brutalize
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
