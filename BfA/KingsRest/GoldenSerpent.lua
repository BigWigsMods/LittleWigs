if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Golden Serpent", nil, 2165, 0) -- XXX Missing InstanceID
if not mod then return end
mod:RegisterEnableMob(17989) -- XXX
--mod.engageId = 0 -- XXX

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
