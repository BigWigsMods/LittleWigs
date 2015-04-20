
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Skadi the Ruthless", 524, 643)
if not mod then return end
mod:RegisterEnableMob(26693)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59322, -- Whirlwind
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 59322, 50228)

	self:Death("Win", 26693)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Whirlwind(args)
	self:Message(59322, "Urgent", "Info")
	self:DelayedMessage(59322, 23, "Attention", CL.soon:format(args.spellName))
	self:Bar(59322, 10, CL.cast:format(args.spellName))
	self:CDBar(59322, 23)
end

