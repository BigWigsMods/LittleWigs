--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Drakkisath", 1583)
if not mod then return end
mod:RegisterEnableMob(10363)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		16805, -- Conflagration
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ConflagrationApply", self:SpellName(16805))
	self:Log("SPELL_AURA_REMOVED", "ConflagrationRemove", self:SpellName(16805))

	self:Death("Win", 10363)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConflagrationApply(args)
	self:PrimaryIcon(16805, args.destName)
	self:TargetBar(16805, 10, args.destName, "yellow")
	self:TargetMessage(16805, args.destName)
end

function mod:ConflagrationRemove(args)
	self:PrimaryIcon(16805)
	self:StopBar(16804, args.destName)
end
