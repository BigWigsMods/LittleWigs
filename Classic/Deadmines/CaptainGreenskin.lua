if BigWigsLoader.isRetail and select(4, GetBuildInfo()) < 110005 then return end -- XXX remove check when 11.0.5 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Greenskin", 36, 2630)
if not mod then return end
mod:RegisterEnableMob(647) -- Captain Greenskin
mod:SetEncounterID(mod:Retail() and 2971 or 2744)
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
