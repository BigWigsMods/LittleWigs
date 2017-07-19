if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viceroy Nezhar", 1178, 1981) -- XXX fix encounter ID
if not mod then return end
mod:RegisterEnableMob(124309) -- Viceroy Nezhar
--mod.engageId = 0000

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"berserk"
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")	
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
