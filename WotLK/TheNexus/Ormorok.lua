--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ormorok the Tree-Shaper", 576, 620)
if not mod then return end
mod:RegisterEnableMob(26794)
mod:SetEncounterID(mod:Classic() and 524 or 2012)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		47981, -- Spell Reflection
		48017, -- Frenzy
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SpellReflection", 47981)
	self:Log("SPELL_AURA_REMOVED", "SpellReflectionRemoved", 47981)
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 48017, 57086)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpellReflection(args)
	self:Message(args.spellId, "yellow")
	self:Bar(args.spellId, 15)
end

function mod:SpellReflectionRemoved(args)
	self:StopBar(args.spellName)
end

function mod:Frenzy()
	self:Message(48017, "red")
end
