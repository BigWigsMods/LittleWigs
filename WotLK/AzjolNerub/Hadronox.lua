-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hadronox", 533, 586)
if not mod then return end
mod:RegisterEnableMob(28921)
-- mod.engageId = 1972 -- ENCOUNTER_START fires when you enter the area, not when you actually pull the boss. Also it doesn't get assigned a boss1 unit.

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		53400, -- Acid Cloud
		53030, -- Poison Leech
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AcidCloud", 53400, 59419)
	self:Log("SPELL_CAST_SUCCESS", "PoisonLeech", 53030, 59417)
	self:Death("Win", 28921)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AcidCloud()
	self:Message(53400, "Attention")
end

function mod:PoisonLeech()
	self:Message(53030, "Attention")
end
