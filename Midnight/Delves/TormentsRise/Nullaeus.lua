--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Nullaeus", 2966)
if not mod then return end
mod:SetEncounterID({3372, 3430})
mod:SetAllowWin(true)
-- TODO private auras, EncounterEvents

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nullaeus = "Nullaeus"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nullaeus
end

function mod:GetOptions()
    return {
    }
end
