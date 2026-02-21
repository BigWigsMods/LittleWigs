--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Spinshroom Midnight", 2963)
if not mod then return end
mod:SetEncounterID(3363)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spinshroom = "Spinshroom"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.spinshroom
end

function mod:GetOptions()
    return {
    }
end
