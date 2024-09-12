--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tendris Warpwood", 429, 406)
if not mod then return end
mod:RegisterEnableMob(11489) -- Tendris Warpwood
mod:SetEncounterID(350)
--mod:SetRespawnTime(0)

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
