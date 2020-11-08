--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Queen Azshara WellOfEternity", 939, 291)
if not mod then return end
mod:RegisterEnableMob(54853, 54884, 54882, 54883) -- Queen Azshara, 3x Enchanted Magi
mod.engageId = 1273
mod.respawnTime = 30

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

function mod:VerifyEnable(unit, mobId)
	if mobId ~= 54853 then return true end -- if Magi are alive, then the encounter can be started
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 102334 then -- Servant of the Queen
		self:MessageOld(-3968, "yellow", "alert")
	end
end

function mod:TotalObedience()
	self:MessageOld(-3969, "orange", "long")
	self:CastBar(-3969, 10)
end

function mod:Interrupt(args)
	if args.extraSpellId == 103241 then -- Total Obedience
		self:MessageOld(-3969, "green", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:StopBar(CL.cast:format(args.extraSpellName))
	end
end
