
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
	self:CDBar(267639, 11.5) -- Burn Corruption
	self:CDBar(267618, 18.5) -- Drain Fluids
	self:CDBar(267702, 29.5) -- Entomb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurnCorruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 13)
end

function mod:DrainFluids(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alarm")
	end
	self:CDBar(args.spellId, 17)
end

function mod:EntombApplied(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info")
	self:StopBar(267639) -- Burn Corruption
	self:StopBar(267618) -- Drain Fluids
	self:StopBar(267702) -- Entomb
end

function mod:EntombRemoved(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 11) -- Burn Corruption
	self:CDBar(args.spellId, 18) -- Drain Fluids
	self:CDBar(args.spellId, 60) -- Entomb XXX Need longer logs
end
