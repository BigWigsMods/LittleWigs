--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Aurius Rivendare", 329, 456)
if not mod then return end
mod:RegisterEnableMob(mod:Retail() and 45412 or 10440) -- Lord Aurius Rivendare, Baron Rivendare
mod:SetEncounterID(484)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.death_pact_trigger = "attempts to cast Death Pact on his servants!"
end

--------------------------------------------------------------------------------
-- Initialization
--

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
