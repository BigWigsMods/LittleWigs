--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Diathorus the Seeker", 2784)
if not mod then return end
mod:RegisterEnableMob(227019) -- Diathorus the Seeker
mod:SetEncounterID(3024)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.diathorus_the_seeker = "Diathorus the Seeker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.diathorus_the_seeker
end

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
