-- TO DO List
-- Timers kinda screw up after Mass Repentance Phase
-- Add warning to soak yellow before Mass rep cast success
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maiden of Virtue", 1115, 1825)
if not mod then return end
mod:RegisterEnableMob(113971)
mod.engageId = 1954
--------------------------------------------------------------------------------
-- Locals
--
local sacredCount = 1
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227817, -- Holy Bulwark Removed
		227823, -- Holy Wrath
		227800, -- Holy Shock
		227809, -- Holy Bolt
		227509, -- Mass Repentance
		{227789, "SAY", "FLASH"}, -- Sacred Ground
	}
end

function mod:OnBossEnable()
	self:log("SPELL_AURA_REMOVED", "HolyBulwarkRemoved", 227817)
	self:Log("SPELL_CAST_START", "HolyShock", 227800)
	self:Log("SPELL_CAST_START", "HolyWrath", 227823)
	self:Log("SPELL_CAST_START", "HolyBolt", 227809)
	self:Log("SPELL_CAST_START", "MassRepentance", 227509)
	self:Log("SPELL_CAST_START", "SacredGround", 227789)
end

function mod:OnEngage()
	sacredCount = 1
	self:Bar(227809, 8) -- Holy Bolt
	self:Bar(227789, 10.1) -- Sacred Ground
	self:Bar(227800, 15) -- Holy Shock
	self:Bar(227509, 47.5) -- Mass Rep
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:SacredGround(args)
	self:CDBar(args.spellId, sacredCount % 2 == 1 and 24 or 32)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
	end
end

function mod:HolyShock(args)
	self:CDBar(args.spellId, 12)
	if self:Interrupter(args.sourceGUID) then
		self:Message(args.spellId, "Attention", "Alarm", CL.incoming:format(args.spellName))
	end
end

function mod:HolyWrath(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

function mod:MassRepentance(args)
	self:Message(args.spellId, "Attention", "Warning", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName))
	self:Bar(args.spellId, 51)
end

function mod:HolyBulwarkRemoved(args)
	self:Message(227823, "Urgent", self:Interrupter(args.sourceGUID) and "Alert", CL.casting:format(self:SpellName(227823)))
end

function mod:HolyBolt(args)
	self:CDBar(args.spellId, 12)
	self:Message(args.spellId, "Important")
end
