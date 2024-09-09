--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chief Ukorz Sandscalp", 209, 489)
if not mod then return end
mod:RegisterEnableMob(
	7267, -- Chief Ukorz Sandscalp
	7797 -- Ruuzlu
)
mod:SetEncounterID(600)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

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
