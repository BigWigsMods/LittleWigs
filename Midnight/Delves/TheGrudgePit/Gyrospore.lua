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

local L = mod:GetLocale()
if L then
	L.gyrospore = "Gyrospore"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.gyrospore
end

function mod:GetOptions()
    return {
    }
end
