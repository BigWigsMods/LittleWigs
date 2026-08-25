--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Infiltrator Garand", 2933)
if not mod then return end
mod:SetEncounterID(3405)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	infiltrator_garand = "Infiltrator Garand",
})
mod.displayName = L.infiltrator_garand

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
