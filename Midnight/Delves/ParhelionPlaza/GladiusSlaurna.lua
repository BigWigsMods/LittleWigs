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

local L = mod:GetLocale()
if L then
	L.gladius_slaurna = "Gladius Slaurna"
end

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
