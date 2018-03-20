-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Asira Dawnslayer", 940)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(54968)
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
	self:Death("Win", 54986)
end

-------------------------------------------------------------------------------
--  Event Handlers
