-- XXX Ulic: I've only run this on normal, had players getting dc'd
-- XXX Ulic: Need to understand the tactics better
-- XXX Ulic: Possibly a bar for when the first wave of adds will come?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Priestess Azil", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42333)
mod.toggleOptions = {
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 42333)
end

-------------------------------------------------------------------------------
--  Event Handlers

