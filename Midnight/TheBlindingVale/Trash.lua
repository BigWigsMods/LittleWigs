--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Blinding Vale Trash", 2859)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	[1238084] = {soundOnApplied = "none"}, -- Spore Spines
	[1237858] = {soundOnApplied = "underyou"}, -- Ruptured Earth
	[1238076] = {soundOnApplied = "none"}, -- Thornblade
	[1242135] = {soundOnApplied = "none"}, -- Grievous Gash
	[1251345] = {soundOnApplied = "underyou"}, -- Blight Resin
	[1250937] = {soundOnApplied = "none"}, -- Toxic Spew
	[1238294] = {soundOnApplied = "none"}, -- Disorienting Screech
	[1238368] = {soundOnApplied = "none"}, -- Lightmaw Beams
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
