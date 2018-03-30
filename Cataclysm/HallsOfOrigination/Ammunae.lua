-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ammunae", 644, 128)
if not mod then return end
mod:RegisterEnableMob(39731)
mod.engageId = 1074
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		76043, -- Wither
		80968, -- Consume Life Energy
		75790, -- Rampant Growth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Wither", 76043)
	self:Log("SPELL_AURA_APPLIED", "WitherApplied", 76043)
	self:Log("SPELL_AURA_REMOVED", "WitherRemoved", 76043)

	self:Log("SPELL_AURA_APPLIED", "ConsumeLifeEnergy", 80968)
	self:Log("SPELL_AURA_REMOVED", "ConsumeLifeEnergyOver", 80968)

	self:Log("SPELL_CAST_START", "RampantGrowth", 75790)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Wither(args)
	self:Message(args.spellId, "Important", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 19)
end

function mod:WitherApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:WitherRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:ConsumeLifeEnergy(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Long", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 4, args.destName)
	self:CDBar(args.spellId, 20)
end

function mod:ConsumeLifeEnergyOver(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:RampantGrowth(args)
	self:Message(args.spellId, "Attention", "Info", CL.casting:format(args.spellName))
end
