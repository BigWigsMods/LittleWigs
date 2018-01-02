-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Benedictus", 819)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54938)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then

end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54938)
end

-------------------------------------------------------------------------------
--  Event Handlers
