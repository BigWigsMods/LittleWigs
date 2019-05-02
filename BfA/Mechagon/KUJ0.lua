if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("K.U.-J.0.", 2097, 2339)
if not mod then return end
mod:RegisterEnableMob(144246)
mod.engageId = 2339

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {

	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
