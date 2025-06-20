if not BigWigsLoader.isNext then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soul-Scribe", 2830, 2677)
if not mod then return end
mod:RegisterEnableMob(234935) -- Soul-Scribe
mod:SetEncounterID(3109)
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
