
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Vizier Ertan", 769, 114)
if not mod then return end
mod:RegisterEnableMob(43878)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		86340, -- Summon Tempest
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonTempest", 86340)

	self:Death("Win", 43878)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonTempest(args)
	self:Bar(args.spellId, 19)
	self:Message(args.spellId, "Attention")
end

