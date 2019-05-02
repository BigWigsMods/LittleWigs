if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Operation: Mechagon Trash", 2097)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then

end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {

	}, {

	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
end

--------------------------------------------------------------------------------
-- Event Handlers
--
