if not BigWigsLoader.isNext then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azhiccar", 2830, 2675)
if not mod then return end
mod:RegisterEnableMob(234893) -- Azhiccar
mod:SetEncounterID(3107)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
