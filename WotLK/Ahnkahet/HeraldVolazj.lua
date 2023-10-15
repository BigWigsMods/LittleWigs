--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Herald Volazj", 619, 584)
if not mod then return end
mod:RegisterEnableMob(29311)
mod:SetEncounterID(mod:Classic() and 215 or 1968)

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
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Insanity(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
end

function mod:Shiver(args)
	self:TargetMessage(59978, "yellow", args.destName)
	self:TargetBar(59978, 15, args.destName)
end

function mod:ShiverRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
