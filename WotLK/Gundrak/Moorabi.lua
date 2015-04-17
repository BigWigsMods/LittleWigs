
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Moorabi", 530, 594)
if not mod then return end
mod:RegisterEnableMob(29305)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		55098, -- Transformation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Transformation", 55098)
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")

	self:Death("Win", 29305)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Transformation(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 4)
end

function mod:Interrupt(args)
	if args.extraSpellId == 55098 then -- Transformation
		self:Message(args.extraSpellId, "Positive", nil, ("%s (%s)"):format(self:SpellName(134340), self:ColorName(args.sourceName))) -- 134340 = "Interrupted"
		self:StopBar(args.amount) -- Name of interrupted spell
	end
end

