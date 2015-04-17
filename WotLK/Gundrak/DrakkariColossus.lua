
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Drakkari Colossus", 530, 593)
if not mod then return end
mod:RegisterEnableMob(29307)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		54850, -- Emerge
		54878, -- Merge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Emerge", 54850) -- To Elemental
	self:Log("SPELL_CAST_START", "Merge", 54878) -- To Colossus

	self:Death("Win", 29307)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Emerge(args)
	self:Message(args.spellId, "Attention", nil, -6421) -- Phase 2: The Elemental
end

function mod:Merge(args)
	self:Message(args.spellId, "Important", nil, -6418) -- Phase 1: The Colossus
end

