-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Corla, Herald of Twilight", 645, 106)
if not mod then return end
mod:RegisterEnableMob(39679)
mod.engageId = 1038
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local warnedAboutEvolution = nil

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{75697, "FLASH"}, -- Evolution
		75823, -- Dark Command
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "Evolution", 75697)
	self:Log("SPELL_AURA_REMOVED", "EvolutionRemoved", 75697)

	self:Log("SPELL_CAST_START", "DarkCommand", 75823)
	self:Log("SPELL_AURA_APPLIED", "DarkCommandApplied", 75823)
	self:Log("SPELL_AURA_REMOVED", "DarkCommandRemoved", 75823)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Evolution(args)
	if self:Me(args.destGUID) and args.amount >= 80 and not warnedAboutEvolution then
		warnedAboutEvolution = true
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue", "warning")
		self:Flash(args.spellId)
	end
end

function mod:EvolutionRemoved(args)
	if self:Me(args.destGUID) and warnedAboutEvolution then
		warnedAboutEvolution = nil
		self:MessageOld(args.spellId, "green", nil, CL.removed:format(args.spellName))
	end
end

function mod:DarkCommand(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "alert", CL.casting:format(args.spellName))
end

function mod:DarkCommandApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:DarkCommandRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
