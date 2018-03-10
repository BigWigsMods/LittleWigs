-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ghaz'an", 726, 577)
if not mod then return end
mod:RegisterEnableMob(18105)
-- mod.engageId = 1945 -- sometimes doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

