-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Stalker", 726, 579)
if not mod then return end
mod:RegisterEnableMob(17882)
mod.engageId = 1948
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{31715, "PROXIMITY"}, -- Static Charge
		31704, -- Levitate
	}
end

function mod:OnBossEnable()
end

-------------------------------------------------------------------------------
--  Event Handlers
--

