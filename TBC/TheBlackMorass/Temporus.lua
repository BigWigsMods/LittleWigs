
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Temporus", 269, 553)
if not mod then return end
mod:RegisterEnableMob(17880)
-- mod.engageId = 1921 -- TODO: check if wipes work fine

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		31458, -- Hasten
		38592, -- Spell Reflection
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "HastenApplied", 31458)
	self:Log("SPELL_DISPEL", "HastenDispelled", "*")
	self:Log("SPELL_AURA_APPLIED", "SpellReflectionApplied", 38592)
	self:Log("SPELL_AURA_REMOVED", "SpellReflectionRemoved", 38592)

	self:Death("Win", 17880)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HastenApplied(args)
	if self:MobId(args.destGUID) == 17880 then -- Mages can spellsteal it
		self:Message(args.spellId, "yellow", CL.magic_buff_boss:format(args.spellName))
		self:TargetBar(args.spellId, 10, args.destName)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:HastenDispelled(args)
	if self:MobId(args.destGUID) == 17880 and args.extraSpellName == self:SpellName(31458) then
		self:StopBar(args.extraSpellName, args.destName)
		self:Message(31458, "green", CL.removed_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	end
end

function mod:SpellReflectionApplied(args)
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, self:Classic() and 8 or 6)
	self:PlaySound(args.spellId, "warning")
end

function mod:SpellReflectionRemoved(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
