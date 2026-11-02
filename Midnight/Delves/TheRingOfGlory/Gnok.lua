--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gnok", 3077)
if not mod then return end
mod:SetEncounterID(3514)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gnok = "Gnok",
})
mod.displayName = L.gnok

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1306124, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Ruptured Ground
	{1305936, tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1306314))}, -- Pulverize
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
