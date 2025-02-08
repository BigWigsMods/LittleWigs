--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hans and Greta", 2875)
if not mod then return end
mod:RegisterEnableMob(
	238422, -- Hans
	238423 -- Greta
)
mod:SetEncounterID(3168) -- Opera of Malediction
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hans_and_greta = "Hans and Greta"
	L.hans = "Hans"
	L.greta = "Greta"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.hans_and_greta
end

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
end

--function mod:OnEngage()
	-- can pull either boss first
--end

--------------------------------------------------------------------------------
-- Event Handlers
--
