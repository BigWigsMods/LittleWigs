--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Infiltrator Garand", 2933)
if not mod then return end
mod:SetEncounterID(3405)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.infiltrator_garand = "Infiltrator Garand"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.infiltrator_garand
end

function mod:GetOptions()
    return {
    }
end
