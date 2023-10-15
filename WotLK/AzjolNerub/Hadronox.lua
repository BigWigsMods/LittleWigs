-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hadronox", 601, 586)
if not mod then return end
mod:RegisterEnableMob(28921)
--mod:SetEncounterID(mod:Classic() and 217 or 1972) -- ENCOUNTER_START fires when you enter the area, not when you actually pull the boss. Also it doesn't get assigned a boss1 unit.

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		53400, -- Acid Cloud
		53030, -- Leech Poison
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AcidCloud", 53400, 59419) -- normal, heroic
	self:Log("SPELL_CAST_SUCCESS", "LeechPoison", 53030, 59417) -- normal, heroic
	self:Death("Win", 28921)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AcidCloud()
	self:Message(53400, "yellow")
end

function mod:LeechPoison()
	self:Message(53030, "orange")
end
