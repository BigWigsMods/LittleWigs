
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Sylvanas", 820, 323)
if not mod then return end
mod:RegisterEnableMob(54123)

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
		-3951, --Shriek of the Highborne
	}
end

function mod:OnBossEnable()

	self:Death("Win", 54123)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
