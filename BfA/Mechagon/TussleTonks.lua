if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tussle Tonks", 2097, 2336)
if not mod then return end
mod:RegisterEnableMob(144244, 145185) -- The Platinum Pummeler, Gnomercy 4.U.
--mod.engageId = XXX

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
