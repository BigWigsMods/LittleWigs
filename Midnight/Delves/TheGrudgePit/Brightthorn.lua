--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Brightthorn", 2963)
if not mod then return end
mod:SetEncounterID(3364)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.brightthorn = "Brightthorn"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.brightthorn
end

function mod:GetOptions()
    return {
    }
end
