
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Jaina", 938, 285)
if not mod then return end
mod:RegisterEnableMob(54445)
mod.engageId = 1883
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
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

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
