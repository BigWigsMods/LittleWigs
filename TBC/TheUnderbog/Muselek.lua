-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Swamplord Musel'ek", 726, 578)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17826, 17827)
mod.toggleOptions = {"stages"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBosEnable()
	self:Death("Win", 17826)
end
