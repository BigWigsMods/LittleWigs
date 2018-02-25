if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", nil, 2144, 1877)
if not mod then return end
mod:RegisterEnableMob(17849) -- XXX
mod.engageId = 2126

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"berserk",
	}
end

function mod:OnBossEnable()
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
