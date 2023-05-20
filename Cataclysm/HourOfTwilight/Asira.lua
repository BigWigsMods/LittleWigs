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
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 54986)
end

-------------------------------------------------------------------------------
--  Event Handlers
