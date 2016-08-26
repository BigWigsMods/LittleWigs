
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ashgolm", 1045, 1468)
if not mod then return end
mod:RegisterEnableMob(95886)
--mod.engageId = 1816

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

	self:Death("Win", 95886)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

