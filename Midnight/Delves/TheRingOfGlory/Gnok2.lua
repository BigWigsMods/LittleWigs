--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Gnok?", 3077)
if not mod then return end
mod:SetEncounterID(3515)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gnok2 = "Gnok?",
})
mod.displayName = L.gnok2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
