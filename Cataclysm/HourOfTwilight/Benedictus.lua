-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Benedictus", 940)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54938)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then

end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54938)
end

-------------------------------------------------------------------------------
--  Event Handlers
