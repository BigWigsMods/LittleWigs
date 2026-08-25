--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Hydrangea", 2933)
if not mod then return end
mod:SetEncounterID(3367)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	hydrangea = "Hydrangea",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.hydrangea
end

function mod:GetOptions()
	return {
	}
end
