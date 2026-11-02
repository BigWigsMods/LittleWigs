--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Drakta", 3077)
if not mod then return end
mod:SetEncounterID(3535)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	drakta = "Drakta",
})
mod.displayName = L.drakta

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
