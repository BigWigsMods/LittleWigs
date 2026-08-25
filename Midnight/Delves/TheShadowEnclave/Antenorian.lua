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

local L = mod:SetDefaultLocale({
	antenorian = "Antenorian",
})
mod.displayName = L.antenorian

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
