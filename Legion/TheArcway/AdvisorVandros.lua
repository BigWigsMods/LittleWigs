
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Vandros", 1079, 1501)
if not mod then return end
mod:RegisterEnableMob(98208)
--mod.engageId = 1829

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153764, -- Claws of Argus
		{153392, "FLASH", "ICON", "PROXIMITY"}, -- Curtain of Flame
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 98208)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

