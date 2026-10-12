--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Blinding Vale Trash", 2859)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1238084, header = 245410, dispel = "magic", soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1238084))}, -- Spore Spines (Lasher)
	{1237858, header = 245346, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Ruptured Earth (Virid Grovekeeper)
	{1238076, header = 245339, dispel = "bleed", mechanic = "bleeding", tip = CL.debuffDotAfterCastNote:format(mod:SpellName(1238066))}, -- Thornblade (Underbrush Stalker)
	{1242135, header = 246871, dispel = "bleed", soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1242135))}, -- Grievous Gash (Luminous Thornmaw)
	{1251345, header = mod:SpellName(1251345), soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Blight Resin (environmental)
	{1250937, header = 249756, dispel = "poison", tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1250937))}, -- Toxic Spew (Potatoad Matriarch)
	{1238294, header = 245484, mechanic = "disoriented", tip = CL.debuffFailureInterruptNote:format(mod:SpellName(1238294))}, -- Disorienting Screech (Lightfeather Petalwing)
	{1238368, header = 245513, soundOnApplied = "alarm", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1238368))}, -- Lightmaw Beams (Overgrown Hydra)
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- TODO there is an autotalk in here (Light-Starved Blossom)
	}
end
