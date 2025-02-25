if select(4, GetBuildInfo()) < 110100 then return end -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Ul'thul", 2815)
if not mod then return end
mod:RegisterEnableMob(234339) -- Harbinger Ul'thul
mod:SetEncounterID(3096)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.harbinger_ulthul = "Harbinger Ul'thul"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.harbinger_ulthul
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
