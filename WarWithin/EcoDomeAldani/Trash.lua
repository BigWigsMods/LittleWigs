if not BigWigsLoader.isNext then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eco-Dome Al'dani Trash", 2830)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	244927, -- Terrified Broker
	234912, -- Ravaging Scavenger
	242209, -- Overgorged Mite
	234870, -- Invading Mite
	234883, -- Voracious Gorger
	236995, -- Ravenous Destroyer
	242631, -- Overcharged Sentinel
	234962, -- Wastelander Farstalker
	234960, -- Tamed Ruinstalker
	234957, -- Wastelander Ritualist
	234955, -- Wastelander Pactspeaker
	235151, -- K'aresh Elemental
	245092, -- Burrowing Creeper
	234918 -- Wastes Creeper
)

--------------------------------------------------------------------------------
-- Localization
--

--local L = mod:GetLocale()
--if L then
--end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}, {
	}
end

function mod:OnBossEnable()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
