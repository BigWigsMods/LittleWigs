
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Chrono Lord Deja", 269, 552)
if not mod then return end
mod:RegisterEnableMob(17879)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		31467, -- Time Lapse, XXX revise this module
	}
end

function mod:OnBossEnable()
	--self:Log("SPELL_AURA_APPLIED", "Enrage", 37605)
	--self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 37605)

	self:Death("Win", 17879)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

--function mod:Enrage(args)
--	self:MessageOld(args.spellId, "orange")
--	self:Bar(args.spellId, 8)
--end
--
--function mod:EnrageRemoved(args)
--	self:StopBar(args.spellName)
--end

