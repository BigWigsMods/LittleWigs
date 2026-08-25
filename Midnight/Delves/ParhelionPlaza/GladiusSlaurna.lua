--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Gladius Slaurna", 2953)
if not mod then return end
mod:SetEncounterID(3307)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gladius_slaurna = "Gladius Slaurna",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.gladius_slaurna
end

function mod:GetOptions()
	return {
	}
end
