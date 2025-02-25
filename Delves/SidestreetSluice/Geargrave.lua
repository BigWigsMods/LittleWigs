if select(4, GetBuildInfo()) < 110100 then return end -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Geargrave", 2826)
if not mod then return end
mod:RegisterEnableMob(234949) -- Geargrave
--mod:SetEncounterID(3174) -- encounter events don't fire
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.geargrave = "Geargrave"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.geargrave
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
