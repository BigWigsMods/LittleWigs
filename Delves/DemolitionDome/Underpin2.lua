--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underpin 2", 2831)
if not mod then return end
--mod:RegisterEnableMob(236626, 234168) -- The Underpin (Tier 11)
--mod:SetEncounterID(3126) TODO both versions are temporarily handled by Underpin.lua
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_underpin = "The Underpin (Tier 11)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_underpin
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
