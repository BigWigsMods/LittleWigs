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

local L = mod:GetLocale()
if L then
	L.blademaster_darza = "Blademaster Darza"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.blademaster_darza
end

function mod:GetOptions()
    return {
    }
end
