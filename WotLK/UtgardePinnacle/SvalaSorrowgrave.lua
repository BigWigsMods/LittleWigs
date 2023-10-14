--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Svala Sorrowgrave", 575, 641)
if not mod then return end
mod:RegisterEnableMob(26668)
mod:SetEncounterID(mod:Classic() and 577 or 2030)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{48276, "CASTBAR"}, -- Ritual of the Sword
		48267, -- Ritual Preparation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RitualOfTheSword", 48276)
	self:Log("SPELL_AURA_APPLIED", "RitualPreparation", 48267)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RitualOfTheSword(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:DelayedMessage(args.spellId, 36, "yellow", CL.soon:format(args.spellName))
	self:CastBar(args.spellId, 26)
	self:CDBar(args.spellId, 36)
end

function mod:RitualPreparation(args)
	self:TargetMessage(args.spellId, "red", args.destName)
end
