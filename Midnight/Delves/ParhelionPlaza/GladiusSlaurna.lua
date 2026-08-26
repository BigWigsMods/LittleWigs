--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Gladius Slaurna", 2953)
if not mod then return end
mod:SetEncounterID(3307)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gladius_slaurna = "Gladius Slaurna",
})
mod.displayName = L.gladius_slaurna

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
