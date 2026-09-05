--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidscar Arena Trash", 2923)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1267894, tip = "You've been hit by a Savage Leap."}, -- Savage Leap
	{1298899, note = CL.debuffFailureInterruptNote:format(mod:SpellName(1298899)), tip = "You failed to interrupt Demoralizing Shout."}, -- Demoralizing Shout
	{1249712, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, dispel = "Poison", tip = "You're standing in Venomous Spit, move out of it."}, -- Venomous Spit
	{1299133, tip = "You've been hit by a Ferocious Leap."}, -- Ferocious Leap
	{1298922, tip = "You've been hit by Savage Smash."}, -- Savage Smash
	{1298917, tip = "You've been hit by a Champion's Spear."}, -- Champion's Spear
	{1299210, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, tip = "You're standing in an Aftershock, move out of it."}, -- Aftershock
	{1299913, soundOnApplied = "alarm", dispel = "Magic", tip = "You've been hit by a Null Eruption, dispel it or heal through it."}, -- Null Eruption
	{1234833, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, dispel = "Disease", tip = "You're standing in a Ravenous Swarm, move out of it."}, -- Ravenous Swarm
	{1250043, soundOnAppliedDose = "none", tip = "A stacking debuff from Melt Armor, reducing your armor the longer it's left up."}, -- Melt Armor
	{1249238, tip = "You've been hit by Fire Spit."}, -- Fire Spit
	{1249621, tip = "You've been hit by Violent Sand."}, -- Violent Sand
	{1233535, tip = "A stacking debuff from Shred Defense, reducing your armor the longer it's left up."}, -- Shred Defense
	{1233398, soundOnApplied = "warning", note = CL.debuffFailureInterruptNote:format(mod:SpellName(1233398)), tip = "You failed to interrupt Mad Shriek."}, -- Mad Shriek
	{1310309, tip = "You've been hit by Macestorm."}, -- Macestorm
	{1289258, dispel = "Poison", tip = "A poison DoT from Corrosive Essence, dispel it before it gets out of hand."}, -- Corrosive Essence
	{1311778, tip = "A bleed effect from Rip and Slice, heal through it."}, -- Rip and Slice
	{458835, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, dispel = "Poison", tip = "You're standing in Toxic Sludge, move out of it."}, -- Toxic Sludge
	{456057, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, dispel = "Disease", tip = "You're standing in Vile Putrescence, move out of it."}, -- Vile Putrescence
	{1300138, dispel = "Magic", tip = "You've been caught in a Void Beam, move out of it."}, -- Void Beam
	{1252406, tip = "You've been hit by Dreadbellow."}, -- Dreadbellow
	{1300243, tip = "You've been hit by Brutalize."}, -- Brutalize
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
