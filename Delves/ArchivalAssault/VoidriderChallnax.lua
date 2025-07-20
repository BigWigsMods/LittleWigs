if not BigWigsLoader.isNext then return end -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidrider Challnax", 2803)
if not mod then return end
mod:RegisterEnableMob(
	244382, -- Voidripper
	244320 -- Voidrider Challnax
)
mod:SetEncounterID(3330)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.voidripper = "Voidripper"
	L.voidrider_challnax = "Voidrider Challnax"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.voidrider_challnax
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
