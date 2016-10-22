
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warbringer O'mrogg", 710, 568)
if not mod then return end
mod:RegisterEnableMob(16809)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5894, -- Beatdown
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("Win", 16809)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 30618 then -- Beatdown
		self:Message(-5894, "Attention", "Warning")
	end
end
