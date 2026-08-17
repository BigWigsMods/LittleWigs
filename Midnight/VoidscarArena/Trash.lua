--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidscar Arena Trash", 2923)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1267894}, -- Savage Leap
	{1298899, note = CL.debuffFailureInterruptNote:format(mod:SpellName(1298899))}, -- Demoralizing Shout
	{1249712, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Venomous Spit
	{1299133}, -- Ferocious Leap
	{1298922}, -- Savage Smash
	{1298917}, -- Champion's Spear
	{1299210, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Aftershock
	{1299913, soundOnApplied = "alarm"}, -- Null Eruption
	{1234833, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Ravenous Swarm
	{1250043, soundOnAppliedDose = "none"}, -- Melt Armor
	{1249238}, -- Fire Spit
	{1249621}, -- Violent Sand
	{1233535}, -- Shred Defense
	{1233398, soundOnApplied = "warning", note = CL.debuffFailureInterruptNote:format(mod:SpellName(1233398))}, -- Mad Shriek
	{1310309}, -- Macestorm
	{1289258}, -- Corrosive Essence
	{1311778}, -- Rip and Slice
	{458835, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Toxic Sludge
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
