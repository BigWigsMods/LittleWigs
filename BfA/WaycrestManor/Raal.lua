if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raal the Gluttonous", 1862, 2127)
if not mod then return end
mod:RegisterEnableMob(131863)
mod.engageId = 2115

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		264734, -- Consume All
		264931, -- Call Servant
		265002, -- Consume Servants
		264923, -- Tenderize
		264694, -- Rotten Expulsion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ConsumeAll", 264734)
	self:Log("SPELL_CAST_START", "CallServant", 264931)
	self:Log("SPELL_CAST_START", "ConsumeServants", 265002)
	self:Log("SPELL_CAST_START", "Tenderize", 264923)
	self:Log("SPELL_CAST_START", "RottenExpulsion", 264694)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConsumeAll(args)
	self:Message(args.spellId, "orange", "Warning")
end

function mod:CallServant(args)
	self:Message(args.spellId, "yellow", "Long")
end

function mod:ConsumeServants(args)
	self:Message(args.spellId, "orange", "Alert")
end

function mod:Tenderize(args)
	self:Message(args.spellId, "red", "Warning")
end

function mod:RottenExpulsion(args)
	self:Message(args.spellId, "orange", "Alarm")
end
