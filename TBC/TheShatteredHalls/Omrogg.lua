
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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "target", "focus")
	self:AddSyncListener("Beatdown")

	self:Death("Win", 16809)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 30618 then -- Beatdown
		self:Sync("Beatdown")
	end
end

function mod:OnSync(sync)
	if sync == "Beatdown" then
		self:Message(-5894, "Attention", "Warning")
	end
end

