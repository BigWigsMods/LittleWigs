
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Tyrande", 820, 283)
if not mod then return end
mod:RegisterEnableMob(54544)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then

end

--------------------------------------------------------------------------------
-- Initialization
--

-- XXX revise this module
function mod:GetOptions()
	return {
		-4207, --Dark Moonlight
	}
end

function mod:OnBossEnable()

	self:Death("Win", 54544)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
