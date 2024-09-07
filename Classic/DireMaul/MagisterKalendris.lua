--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magister Kalendris", 429, BigWigsLoader.isRetail and 408)
if not mod then return end
mod:RegisterEnableMob(11487) -- Magister Kalendris
mod:SetEncounterID(348)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.magister_kalendris = "Magister Kalendris"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.magister_kalendris
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
