--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ramstein the Gorger", 329, BigWigsLoader.isRetail and 455)
if not mod then return end
mod:RegisterEnableMob(10439) -- Ramstein the Gorger
mod:SetEncounterID(483)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ramstein_the_gorger = "Ramstein the Gorger"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.ramstein_the_gorger
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
