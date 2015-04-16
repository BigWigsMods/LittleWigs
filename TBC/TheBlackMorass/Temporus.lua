
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Temporus", 733, 553)
if not mod then return end
mod:RegisterEnableMob(17880)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		31458, -- Hasten
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Hasten", 31458)
	self:Log("SPELL_AURA_REMOVED", "HastenRemoved", 31458)

	self:Death("Win", 17880)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hasten(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 10)
end

function mod:HastenRemoved(args)
	self:StopBar(args.spellName)
end

