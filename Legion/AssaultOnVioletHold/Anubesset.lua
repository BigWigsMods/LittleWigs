
--------------------------------------------------------------------------------
-- TODO List:
-- - Check spellId/events for BlisteringOozeDamage (202485?)

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'esset", 1066, 1696)
if not mod then return end
mod:RegisterEnableMob(102246)
mod.engageId = 1852

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		202217, -- Mandible Strikes
		202341, -- Impale
		201863, -- Call of the Swarm
		202480, -- Fixated
		202485, -- Blistering Ooze
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MandibleStrikesCast", 202217)
	self:Log("SPELL_AURA_APPLIED", "MandibleStrikesApplied", 202217)
	self:Log("SPELL_CAST_START", "Impale", 202341)
	self:Log("SPELL_CAST_START", "CallOfTheSwarm", 201863)
	self:Log("SPELL_AURA_APPLIED", "Fixated", 202480)
	self:Log("SPELL_AURA_APPLIED", "BlisteringOozeDamage", 202485)
	self:Log("SPELL_PERIODIC_DAMAGE", "BlisteringOozeDamage", 202485)
	self:Log("SPELL_PERIODIC_MISSED", "BlisteringOozeDamage", 202485)
end

function mod:OnEngage()
	self:Bar(202217, 9)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MandibleStrikesCast(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 22)
end

function mod:MandibleStrikesApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:Impale(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 22)
end

function mod:CallOfTheSwarm(args)
	self:Message(args.spellId, "Urgent", "Info")
end

function mod:Fixated(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning")
	end
end

do
	local prev = 0
	function mod:BlisteringOozeDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end
