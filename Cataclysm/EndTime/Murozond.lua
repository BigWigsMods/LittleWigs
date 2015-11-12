
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Murozond", 820, 289)
if not mod then return end
mod:RegisterEnableMob(54432)

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
		-3676, -- Distortion Bomb
	}
end

function mod:OnBossEnable()

	self:Death("Win", 54432)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
