if BigWigsLoader.isRetail and select(4, GetBuildInfo()) < 110005 then return end -- XXX remove check when 11.0.5 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gilnid", 36, 2628)
if not mod then return end
mod:RegisterEnableMob(1763) -- Gilnid
mod:SetEncounterID(mod:Retail() and 2969 or 2743)
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
