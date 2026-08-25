--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Infiltrator Gulkat", 3003)
if not mod then return end
mod:SetEncounterID(3361)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	infiltrator_gulkat = "Infiltrator Gulkat",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.infiltrator_gulkat
end

function mod:GetOptions()
	return {
	}
end
