--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Mul'tha'ul", 2964)
if not mod then return end
mod:SetEncounterID(3359)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.multhaul = "Mul'tha'ul"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.multhaul
end

function mod:GetOptions()
    return {
    }
end
