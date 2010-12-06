-- XXX Ulic: Need logs and suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("\"Captain\" Cookie", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47739)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 47739) 
end

-------------------------------------------------------------------------------
--  Event Handlers

