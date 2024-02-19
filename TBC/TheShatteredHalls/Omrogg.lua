
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warbringer O'mrogg", 540, 568)
if not mod then return end
mod:RegisterEnableMob(16809)
mod.engageId = 1937
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-5894, "SAY", "FLASH"}, -- Beatdown
	}
end

function mod:OnBossEnable()
	if self:Classic() then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function announce(self, target, guid)
		if self:Me(guid) then
			self:Say(-5894, nil, nil, "Beatdown")
			self:Flash(-5894)
		end
		self:TargetMessageOld(-5894, target, "yellow", "warning", nil, nil, true)
	end

	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castId, spellId)
		if spellId == 30618 and castId ~= prev then -- Beatdown
			prev = castId
			self:GetUnitTarget(announce, 0.4, self:UnitGUID(unit))
		end
	end
end
