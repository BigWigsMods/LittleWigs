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

local L = mod:SetDefaultLocale({
	chiefarcanist_patram = "Chief-Arcanist Patram",
})

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
