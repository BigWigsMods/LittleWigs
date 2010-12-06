-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Anraphet", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39788)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 39788)
end

-------------------------------------------------------------------------------
--  Event Handlers

