
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mchimba the Embalmer", 1762, 2171)
if not mod then return end
mod:RegisterEnableMob(134993) -- Mchimba the Embalmer
mod.engageId = 2142

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		267639, -- Burn Corruption
		267618, -- Drain Fluids
		267702, -- Entomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BurnCorruption", 267639)
	self:Log("SPELL_AURA_APPLIED", "DrainFluids", 267618)
	self:Log("SPELL_AURA_APPLIED", "EntombApplied", 267702)
	self:Log("SPELL_AURA_REMOVED", "EntombRemoved", 267702)
end

function mod:OnEngage()
	self:CDBar(267639, 11.1) -- Burn Corruption
	self:CDBar(267618, 17.9) -- Drain Fluids
	self:CDBar(267702, 29.5) -- Entomb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurnCorruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 13) -- pull:11.1, 13.3, 23.9, 13.4, 19.5, 32.8
end

function mod:DrainFluids(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
	self:CDBar(args.spellId, 17) -- pull:17.9, 37.3, 17.0, 17.1
end

function mod:EntombApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	self:StopBar(267639) -- Burn Corruption
	self:StopBar(267618) -- Drain Fluids
	self:StopBar(267702) -- Entomb
end

function mod:EntombRemoved(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CDBar(267639, 10.4) -- Burn Corruption
	self:CDBar(267618, 17.3) -- Drain Fluids
	self:CDBar(args.spellId, 57.3) -- Entomb XXX Need longer logs
end
