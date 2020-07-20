
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ingra Maloch", 2290, 2400)
if not mod then return end
mod:RegisterEnableMob(164567, 170229) -- Ingra Maloch, Droman Oulfarran
mod.engageId = 2397
--mod.respawnTime = 30

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
