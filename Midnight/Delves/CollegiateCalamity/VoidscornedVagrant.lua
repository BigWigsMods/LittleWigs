--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Voidscorned Vagrant", 2933)
if not mod then return end
mod:SetEncounterID(3404)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.voidscorned_vagrant = "Voidscorned Vagrant"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.voidscorned_vagrant
end

function mod:GetOptions()
    return {
    }
end
