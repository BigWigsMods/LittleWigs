
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Prince Shaffar", 732, 537)
if not mod then return end
mod:RegisterEnableMob(18344)
-- mod.engageId = 1899 -- no boss frames, sometimes no ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34605, -- Blink
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 18344)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

