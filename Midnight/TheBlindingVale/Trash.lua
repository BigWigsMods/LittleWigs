--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Blinding Vale Trash", 2859)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1238084, soundOnAppliedDose = "none"}, -- Spore Spines
	{1237858, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Ruptured Earth
	{1238076}, -- Thornblade
	{1242135}, -- Grievous Gash
	{1251345, soundOnApplied = "underyou"}, -- Blight Resin
	{1250937}, -- Toxic Spew
	{1238294}, -- Disorienting Screech
	{1238368, soundOnApplied = "alarm"}, -- Lightmaw Beams
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- TODO there is an autotalk in here (Light-Starved Blossom)
	}
end
