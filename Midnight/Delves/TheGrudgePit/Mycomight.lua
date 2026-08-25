--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Mycomight", 2963)
if not mod then return end
mod:SetEncounterID(3362)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	mycomight = "Mycomight",
})
mod.displayName = L.mycomight

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
