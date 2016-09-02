
--------------------------------------------------------------------------------
-- TODO List:
-- - Does the Focusing Phase have a CD?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Glazer", 1045, 1469)
if not mod then return end
mod:RegisterEnableMob(95887)
mod.engageId = 1817

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194945, -- Lingering Gaze
		194323, -- Focusing
		194333, -- Beamed
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LingeringGazeCast", 194942)
	self:Log("SPELL_AURA_APPLIED", "LingeringGazeApplied", 194945)
	self:Log("SPELL_AURA_APPLIED", "Focusing", 194323)
	self:Log("SPELL_AURA_APPLIED", "Beamed", 194333)
end

function mod:OnEngage()
	self:Bar(194323, 32)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LingeringGazeCast(args)
	self:Message(194945, "Important", "Alarm", CL.casting:format(args.spellName))
end

function mod:LingeringGazeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end

function mod:Focusing(args)
	self:Message(args.spellId, "Urgent", "Info")
end

function mod:Beamed(args)
	self:Message(args.spellId, "Positive", "Info")
	self:Bar(args.spellId, 15)
end
