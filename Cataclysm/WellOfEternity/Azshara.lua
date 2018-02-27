--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Queen Azshara", 816, 291)
if not mod then return end
mod:RegisterEnableMob(54853, 54884, 54882, 54883) -- Queen Azshara, Enchanted Magi
mod.engageId = 1273
mod.respawnTime = 30

local canEnable = true

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-3968, -- Servant of the Queen
		-3969, -- Total Obedience
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "TotalObedience", 103241)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 102334 then -- Servant of the Queen
		self:Message(-3968, "Attention", "Alert", spellId)
	end
end

function mod:TotalObedience(args)
	self:Message(-3969, "Urgent", "Long", args.spellId)
	self:CastBar(-3969, 10)
end

function mod:Interrupt(args)
	if args.extraSpellId == 103241 then -- Total Obedience
		self:Message(-3969, "Positive", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:StopBar(CL.cast:format(args.extraSpellName))
	end
end
