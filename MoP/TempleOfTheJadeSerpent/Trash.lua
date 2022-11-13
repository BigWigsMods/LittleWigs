--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of the Jade Serpent Trash", 960)
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

-- corrupt living water surging deluge ground aoe avoidable

-- fallen waterspeaker tidal burst interruptible aoe nuke

-- haunting sha fear cast (haunting scream - interruptible)

-- nodding tiger heal (interrupt cat nap heal)

-- the golden beetle (shield magic offensive dispel)

-- talking fish sleep (interruptible, def magic dispel)

-- sha-touched guardian leg sweep
