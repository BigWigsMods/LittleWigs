--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Chief-Arcanist Patram", 2979)
if not mod then return end
mod:SetEncounterID(3365)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.chiefarcanist_patram = "Chief-Arcanist Patram"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.chiefarcanist_patram
end

function mod:GetOptions()
    return {
    }
end
