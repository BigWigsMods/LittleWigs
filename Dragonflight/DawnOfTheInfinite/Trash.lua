if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dawn of the Infinite Trash", 2579)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(

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

