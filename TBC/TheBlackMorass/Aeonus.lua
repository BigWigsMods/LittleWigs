
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
		37605, -- Enrage / Frenzy (different name on classic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EnrageFrenzyApplied", 37605)
	self:Log("SPELL_DISPEL", "EnrageFrenzyDispelled", "*")

	self:Death("Win", 17881)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EnrageFrenzyApplied(args)
	self:Message(args.spellId, "orange")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:EnrageFrenzyDispelled(args)
	if args.extraSpellName == self:SpellName(37605) then
		self:StopBar(args.extraSpellName, args.destName)
		self:Message(37605, "green", CL.removed_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	end
end
