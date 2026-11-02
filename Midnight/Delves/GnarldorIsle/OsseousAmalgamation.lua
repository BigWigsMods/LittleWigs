--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Osseous Amalgamation", 3038)
if not mod then return end
mod:SetEncounterID(3560)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	osseous_amalgamation = "Osseous Amalgamation",
})
mod.displayName = L.osseous_amalgamation

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
