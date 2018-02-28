﻿-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Drakos the Interrogator", nil, 622, 578)
if not mod then return end
--mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27654)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:Death("Win", 27654)
end
