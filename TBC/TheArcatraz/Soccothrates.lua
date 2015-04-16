
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Wrath-Scryer Soccothrates", 731, 550)
if not mod then return end
mod:RegisterEnableMob(20886)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		36512, -- Knock Away
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "KnockAway", 36512)

	self:Death("Win", 20886)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:KnockAway(args)
	self:Message(args.spellId, "Important")
end

