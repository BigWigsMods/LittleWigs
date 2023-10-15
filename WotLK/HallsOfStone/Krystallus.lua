-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Krystallus", 599, 604)
if not mod then return end
mod:RegisterEnableMob(27977)
mod:SetEncounterID(mod:Classic() and 563 or 1994)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		50810, -- Shatter
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "GroundSlam", 50833)
	self:Log("SPELL_CAST_START", "Shatter", 50810, 61546) -- normal, heroic
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:GroundSlam()
	self:CDBar(50810, 8) -- Shatter
	self:Message(50810, "orange", CL.soon:format(self:SpellName(50810)))
end

function mod:Shatter()
	self:StopBar(50810)
	self:Message(50810, "orange")
end
