if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Delve Rares", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rares = "Rares"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.rares
end

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
