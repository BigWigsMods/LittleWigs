--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidscar Arena Trash", 2923)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1267894}, -- Savage Leap
	{1299913}, -- Null Eruption
	{1250043}, -- Melt Armor
	{1234833}, -- Ravenous Swarm
	{1249712}, -- Venomous Spit
	{1233535}, -- Shred Defense
	{1300138}, -- Void Beam
	{1252406}, -- Dreadbellow
	{1300243}, -- Brutalize
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
