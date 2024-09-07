--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Timmy the Cruel", 329, BigWigsLoader.isRetail and 445)
if not mod then return end
mod:RegisterEnableMob(10808) -- Timmy the Cruel
mod:SetEncounterID(474)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.timmy_the_cruel = "Timmy the Cruel"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.timmy_the_cruel
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
