
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Cookie", 756, 93)
if not mod then return end
mod:RegisterEnableMob(47739)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		89252, -- Cauldron Fire
	}
end

function mod:OnBossEnable()
	-- XXX revise this module
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 47739)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

