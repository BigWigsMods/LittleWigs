
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rokmora", 1065, 1662)
if not mod then return end
mod:RegisterEnableMob(91003)
mod.engageId = 1790

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		188169, -- Razor Shards
		188114, -- Shatter
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:Log("SPELL_CAST_START", "Shatter", 188114)
end

function mod:OnEngage()
	self:CDBar(188169, 25) -- Razor Shards
	self:CDBar(188169, 20) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RazorShards(args)
	self:Message(args.spellId, "orange", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 29)
end

function mod:Shatter(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:CDBar(args.spellId, 24)
end

