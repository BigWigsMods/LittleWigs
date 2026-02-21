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

local L = mod:GetLocale()
if L then
	L.lumenia = "Lumenia"
end

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
