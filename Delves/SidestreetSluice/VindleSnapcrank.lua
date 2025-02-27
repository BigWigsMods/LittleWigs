--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vindle Snapcrank", 2826)
if not mod then return end
mod:RegisterEnableMob(234931) -- Vindle Snapcrank
--mod:SetEncounterID(3173) -- encounter events don't fire
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vindle_snapcrank = "Vindle Snapcrank"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.vindle_snapcrank
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
