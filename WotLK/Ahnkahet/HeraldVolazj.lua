
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Herald Volazj", 619, 584)
if not mod then return end
mod:RegisterEnableMob(29311)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		57496, -- Insanity
		59978, -- Shiver
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Insanity", 57496)
	self:Log("SPELL_AURA_APPLIED", "Shiver", 57949, 59978)
	self:Log("SPELL_AURA_REMOVED", "ShiverRemoved", 57949, 59978)

	self:Death("Win", 29311)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Insanity(args)
	self:MessageOld(args.spellId, "red", nil, CL.casting:format(args.spellName))
end

function mod:Shiver(args)
	self:TargetMessageOld(59978, args.destName, "yellow")
	self:TargetBar(59978, 15, args.destName)
end

function mod:ShiverRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

