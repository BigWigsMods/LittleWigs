
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karazhan Trash", 1115)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"berserk"
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	
end

