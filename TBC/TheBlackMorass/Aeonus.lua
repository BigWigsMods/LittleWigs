
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Aeonus", 269, 554)
if not mod then return end
mod:RegisterEnableMob(17881)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.reset_trigger = "No! Damn this feeble, mortal coil!" -- XXX implement?
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		37605, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Enrage", 37605)
	self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 37605)

	self:Death("Win", 17881)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Enrage(args)
	self:MessageOld(args.spellId, "orange")
	self:Bar(args.spellId, 8)
end

function mod:EnrageRemoved(args)
	self:StopBar(args.spellName)
end

