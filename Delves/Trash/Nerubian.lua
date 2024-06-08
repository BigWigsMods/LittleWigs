if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerubian Delve Trash", {2680, 2684, 2685, 2688}) -- Earthcrawl Mines, The Dread Pit, Skittering Breach, The Spiral Weave
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
end

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
