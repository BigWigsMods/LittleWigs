
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helya", 1042, 1663)
if not mod then return end
mod:RegisterEnableMob(96759)
--mod.engageId = 1824

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

	self:Death("Win", 96759)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

