--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Antenorian", 2952)
if not mod then return end
mod:SetEncounterID(3368)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.antenorian = "Antenorian"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.antenorian
end

function mod:GetOptions()
    return {
    }
end
