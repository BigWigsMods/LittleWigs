
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Jaina", 820, 285)
if not mod then return end
mod:RegisterEnableMob(54445)

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
		-3641, -- Blink
	}
end

function mod:OnBossEnable()

	self:Death("Win", 54445)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
