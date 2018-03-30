-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Arcurion", 940)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54590)
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
	self:Death("Win", 54590)
end

-------------------------------------------------------------------------------
--  Event Handlers
