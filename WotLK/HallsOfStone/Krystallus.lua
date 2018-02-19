-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Krystallus", 599, 604)
if not mod then return end
--mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27977)

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
	self:Log("SPELL_CAST_START", "Shatter", 50810, 61546)
	self:Death("Win", 27977)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:GroundSlam()
	self:CDBar(50810, 8) -- Shatter
	self:Message(50810, "Urgent", nil, CL.soon:format(self:SpellName(50810)))
end

function mod:Shatter()
	self:StopBar(50810)
	self:Message(50810, "Urgent")
end
