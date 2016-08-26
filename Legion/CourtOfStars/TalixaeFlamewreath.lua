
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talixae Flamewreath", 1087, 1719)
if not mod then return end
mod:RegisterEnableMob(104217)
--mod.engageId = 1869

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

	self:Death("Win", 104217)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

