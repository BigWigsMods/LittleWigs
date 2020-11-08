
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warchief Kargath Bladefist", 540, 569)
if not mod then return end
mod:RegisterEnableMob(16808)
mod.engageId = 1938
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5899, -- Blade Dance
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 30738 then -- Blade Dance Targeting
		self:MessageOld(-5899, "yellow", "warning")
		self:CDBar(-5899, 30)
	end
end
