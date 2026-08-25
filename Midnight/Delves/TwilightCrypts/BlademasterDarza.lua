--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Blademaster Darza", 2961)
if not mod then return end
mod:SetEncounterID(3360)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	blademaster_darza = "Blademaster Darza",
})
mod.displayName = L.blademaster_darza

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
