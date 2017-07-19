if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuraal", 1178, 1979)
if not mod then return end
mod:RegisterEnableMob(122313) -- Zuraal the Ascended
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
