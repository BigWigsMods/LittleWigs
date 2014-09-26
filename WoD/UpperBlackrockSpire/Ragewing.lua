
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Ragewing the Untamed", 995)
if not mod then return end
mod:RegisterEnableMob(76585)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"bosskill",
	}
end

function mod:OnBossEnable()
	--self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 76585)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--


