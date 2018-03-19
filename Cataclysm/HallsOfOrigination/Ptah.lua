-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Earthrager Ptah", 644, 125)
if not mod then return end
mod:RegisterEnableMob(39428)
mod.engageId = 1076
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		-2543, -- Tumultuous Earthstorm
	}
end

function mod:OnBossEnable()

end

-------------------------------------------------------------------------------
--  Event Handlers
--
