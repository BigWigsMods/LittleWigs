if not BigWigsLoader.isVanilla or not (BigWigsLoader.isRetail and select(4, GetBuildInfo()) >= 110005) then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hydromancer Velratha", 209, BigWigsLoader.isRetail and 482)
if not mod then return end
mod:RegisterEnableMob(7795) -- Hydromancer Velratha
mod:SetEncounterID(593)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hydromancer_velratha = "Hydromancer Velratha"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	if self:Classic() then
		self.displayName = L.hydromancer_velratha
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
