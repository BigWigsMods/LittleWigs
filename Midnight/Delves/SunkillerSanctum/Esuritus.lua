--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Esuritus", {2953, 2965}) -- Parhelion Plaza, Sunkiller Sanctum
if not mod then return end
mod:SetEncounterID({3398, 3417}) -- Parhelion Plaza, Sunkiller Sanctum
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.esuritus = "Esuritus"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.esuritus
end

function mod:GetOptions()
    return {
    }
end
