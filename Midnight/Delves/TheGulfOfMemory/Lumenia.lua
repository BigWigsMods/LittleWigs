--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Lumenia", 2964)
if not mod then return end
mod:SetEncounterID(3416)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	lumenia = "Lumenia",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.lumenia
end

function mod:GetOptions()
	return {
	}
end
