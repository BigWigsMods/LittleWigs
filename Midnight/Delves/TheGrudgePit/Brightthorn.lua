--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Brightthorn", 2963)
if not mod then return end
mod:SetEncounterID(3364)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	brightthorn = "Brightthorn",
})
mod.displayName = L.brightthorn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
