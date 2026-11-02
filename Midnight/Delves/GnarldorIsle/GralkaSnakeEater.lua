--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Gralka Snake-Eater", 3038)
if not mod then return end
mod:SetEncounterID(3512)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	gralka_snake_eater = "Gralka Snake-Eater",
})
mod.displayName = L.gralka_snake_eater

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
