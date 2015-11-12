
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Augh", 747)
if not mod then return end
mod:RegisterEnableMob(49045)

--------------------------------------------------------------------------------
-- Initialization
--

-- XXX merge with Lockmaw
function mod:GetOptions()
	return {
		84784, -- Whirlwind
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 84784)

	self:Death("Win", 49045)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Whirlwind(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 20)
end

