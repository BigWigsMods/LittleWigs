--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Blinding Vale Trash", 2859)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1238084, soundOnAppliedDose = "none", dispel = "Poison", tip = "A stacking poison DoT from Spore Spines, dispel it before it gets out of hand."}, -- Spore Spines
	{1237858, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, tip = "You're standing on Ruptured Earth, move out of it."}, -- Ruptured Earth
	{1238076, dispel = "Curse", tip = "A cursed wound from Thornblade, dispel it before it gets out of hand."}, -- Thornblade
	{1242135, tip = "A bleed effect from Grievous Gash, heal through it."}, -- Grievous Gash
	{1251345, soundOnApplied = "underyou", dispel = "Disease", tip = "You're standing in Blight Resin, move out of it."}, -- Blight Resin
	{1250937, dispel = "Poison", tip = "A poison DoT from Toxic Spew, dispel it before it gets out of hand."}, -- Toxic Spew
	{1238294, tip = "You've been disoriented by a Disorienting Screech."}, -- Disorienting Screech
	{1238368, soundOnApplied = "alarm", dispel = "Magic", tip = "You're caught in Lightmaw Beams, move out of them."}, -- Lightmaw Beams
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- TODO there is an autotalk in here (Light-Starved Blossom)
	}
end
