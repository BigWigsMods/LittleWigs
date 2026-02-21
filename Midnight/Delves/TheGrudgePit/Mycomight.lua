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

local L = mod:GetLocale()
if L then
	L.mycomight = "Mycomight"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.mycomight
end

function mod:GetOptions()
    return {
    }
end
