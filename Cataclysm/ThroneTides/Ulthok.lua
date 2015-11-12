
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Commander Ulthok", 767, 102)
if not mod then return end
mod:RegisterEnableMob(40765)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		76047, -- Dark Fissure
		{76026, "ICON"}, -- Squeeze
		76100, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fissure", 76047)
	self:Log("SPELL_AURA_APPLIED", "Squeeze", 76026)
	self:Log("SPELL_AURA_REMOVED", "SqueezeRemoved", 76026)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 76100)
	self:Death("Win", 40765)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fissure(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(args.spellName))
end

function mod:Squeeze(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SqueezeRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:Enrage(args)
	self:Message(args.spellId, "Attention")
end

