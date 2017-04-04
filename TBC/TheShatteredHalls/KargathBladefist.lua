
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warchief Kargath Bladefist", 710, 569)
if not mod then return end
mod:RegisterEnableMob(16808)

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
	self:Death("Win", 16808)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 30738 then -- Blade Dance Targeting
		self:Message(-5899, "Attention", "Warning")
		self:CDBar(-5899, 30)
	end
end
