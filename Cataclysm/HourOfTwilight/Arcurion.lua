-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Arcurion", 819)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54590)
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
	self:Death("Win", 54590)
end

-------------------------------------------------------------------------------
--  Event Handlers
