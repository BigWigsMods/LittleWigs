if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1178, 1982) -- XXX fix encounter ID
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
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
