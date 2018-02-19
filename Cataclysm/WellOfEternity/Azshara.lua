--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Queen Azshara", 939, 291)
if not mod then return end
mod:RegisterEnableMob(54853, 54884, 54882, 54883) -- Queen Azshara, Enchanted Magi
mod.engageId = 1273

local canEnable = true

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-3968, -- Servant of the Queen
		-3969, -- Mass Obedience
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "MassObedience", 103241)
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")
end

function mod:OnWin()
	canEnable = nil
end

function mod:VerifyEnable()
	if canEnable then return true end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 102334 then -- Servant of the Queen
		self:Message(-3968, "Attention", "Alert", spellId)
		--self:TargetMessage(-3969, player, "Urgent", "Long", spellId)
		--self:PrimaryIcon(-3969, player)
	end
end

function mod:MassObedience(args)
	self:Message(-3969, "Urgent", "Long", args.spellId)
	self:Bar(-3969, 10, CL.cast:format(args.spellName))
end

function mod:Interrupt(args)
	if args.extraSpellId == 103241 then -- Mass Obedience
		self:Message(-3969, "Positive", nil, ("%s (%s)"):format(self:SpellName(134340), self:ColorName(args.sourceName))) -- 134340 = "Interrupted"
		self:StopBar(CL.cast:format(args.amount)) -- Name of interrupted spell
	end
end
