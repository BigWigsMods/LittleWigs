--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Infiltrator Gulkat", 3003)
if not mod then return end
mod:SetEncounterID(3361)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	infiltrator_gulkat = "Infiltrator Gulkat",
})
mod.displayName = L.infiltrator_gulkat

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
