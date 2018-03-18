-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Setesh", 644, 129)
if not mod then return end
mod:RegisterEnableMob(39732)
mod.engageId = 1079
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		-2670, -- Summon Chaos Portal
	}
end

function mod:OnBossEnable()

end

-------------------------------------------------------------------------------
--  Event Handlers
--
