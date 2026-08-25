--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Spiritflayer Jin'ma", 2962)
if not mod then return end
mod:SetEncounterID({3433, 3434, 3435})
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	spiritflayer_jinma = "Spiritflayer Jin'ma",
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.spiritflayer_jinma
end

function mod:GetOptions()
	return {
	}
end
