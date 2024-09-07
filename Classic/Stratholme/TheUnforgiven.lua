--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Unforgiven", 329, BigWigsLoader.isRetail and 450)
if not mod then return end
mod:RegisterEnableMob(10516) -- The Unforgiven
mod:SetEncounterID(472)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_unforgiven = "The Unforgiven"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.the_unforgiven
	end
end

function mod:GetOptions()
	return {

	}
end

function mod:OnBossEnable()
	if self:Retail() then
		self:RegisterEvent("ENCOUNTER_START") -- XXX no boss frames
	end
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, id) -- XXX no boss frames
	if id == self.engageId then
		self:Engage()
	end
end
