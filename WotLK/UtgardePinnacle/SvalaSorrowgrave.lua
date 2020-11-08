
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Svala Sorrowgrave", 575, 641)
if not mod then return end
mod:RegisterEnableMob(26668)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		48276, -- Ritual of the Sword
		48267, -- Ritual Preparation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RitualOfTheSword", 48276)
	self:Log("SPELL_AURA_APPLIED", "RitualPreparation", 48267)

	self:Death("Win", 26668)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RitualOfTheSword(args)
	self:MessageOld(args.spellId, "orange", "info")
	self:DelayedMessage(args.spellId, 36, "yellow", CL.soon:format(args.spellName))
	self:Bar(args.spellId, 26, CL.cast:format(args.spellName))
	self:CDBar(args.spellId, 36)
end

function mod:RitualPreparation(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
end

