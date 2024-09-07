if not BigWigsLoader.isVanilla and not (BigWigsLoader.isRetail and select(4, GetBuildInfo()) >= 110005) then return end -- XXX remove build check when 11.0.5 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Postmaster Malown", 329, BigWigsLoader.isRetail and 2633)
if not mod then return end
mod:RegisterEnableMob(11143) -- Postmaster Malown
mod:SetEncounterID(mod:Retail() and 1885 or 2798)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.postmaster_malown = "Postmaster Malown"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.postmaster_malown
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
