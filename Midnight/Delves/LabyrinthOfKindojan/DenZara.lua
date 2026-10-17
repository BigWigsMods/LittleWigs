--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Den'Zara", 3043)
if not mod then return end
mod:SetEncounterID(3556)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	denzara = "Den'Zara",
})
mod.displayName = L.denzara

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
