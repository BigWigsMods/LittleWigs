-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Drakos the Interrogator", "The Oculus")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27654)
mod.toggleOptions = {"bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 27654)
end
