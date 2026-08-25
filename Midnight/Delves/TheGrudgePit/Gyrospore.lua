--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Gyrospore", 2963)
if not mod then return end
mod:SetEncounterID(3363)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gyrospore = "Gyrospore",
})
mod.displayName = L.gyrospore

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
