--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Mannoroth and Varo'then", 816, 292)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54969, 55419) --Mannoroth, Varo'then
mod.toggleOptions = {"bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 54969)
end

--------------------------------------------------------------------------------
-- Event Handlers
--


--There is some fire on the ground, warn if you step on it? Can't find it in my log.