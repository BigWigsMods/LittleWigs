--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Witch Doctor Zum'rah", 209, 486)
if not mod then return end
mod:RegisterEnableMob(7271) -- Witch Doctor Zum'rah
mod:SetEncounterID(597)
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
