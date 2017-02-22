if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- TODO List:
-- - Mythic Abilities

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Agronox", 1146, 1905)
if not mod then return end
mod:RegisterEnableMob(117193)
mod.engageId = 2055

--------------------------------------------------------------------------------
-- Locals
--

local sporeCounter = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		236524, -- Poisonous Spores
		235751, -- Timber Smash
		236650, -- Choking Vines
		236527, -- Fulminating Lashers
		{238674, "SAY", "FLASH", "PROXIMITY"}, -- Fixate
		236639, -- Succulent Lashers
		236640, -- Toxic Sap
	},{
		[236524] = "general",
		[236527] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "PoisonousSpores", 236524) -- Poisonous Spores
	self:Log("SPELL_CAST_START", "TimberSmash", 235751) -- Timber Smash
	self:Log("SPELL_AURA_APPLIED", "ChokingVines", 238598) -- Choking Vines
	self:Log("SPELL_CAST_SUCCESS", "FulminatingLashers", 236527) -- Fulminating Lashers
	self:Log("SPELL_AURA_APPLIED", "Fixate", 238674) -- Fulminating Lashers: Fixate
	self:Log("SPELL_AURA_REMOVED", "FixateRemoved", 238674) -- Fulminating Lashers: Fixate
	self:Log("SPELL_CAST_SUCCESS", "SucculentLashers", 236639) -- Succulent Lashers

	-- Toxic Sap // Succulent Secretion
	self:Log("SPELL_AURA_APPLIED", "ToxicSap", 240063, 240065) -- Succulent Secretion x2
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicSap", 240063, 240065) -- Succulent Secretion x2
	self:Log("SPELL_PERIODIC_MISSED", "ToxicSap", 240063, 240065) -- Succulent Secretion x2

end

function mod:OnEngage()
	sporeCounter = 1

	self:Bar(235751, 7) -- Timber Smash
	self:Bar(236524, 10.6, CL.count:format(self:SpellName(236524), sporeCounter)) -- Poisonous Spores
	self:Bar(236527, 15.5) -- Fulminating Lashers
	self:Bar(236639, 20.3) -- Succulent Lashers
	self:Bar(236650, 25.2) -- Choking Vines
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 236650 then -- Choking Vines
		self:Message(236650, "Attention", "Alert", spellName)
		self:Bar(236650, 40.1)
	end
end

function mod:PoisonousSpores(args)
	self:Message(args.spellId, "Attention", "Info", CL.count:format(args.spellName, sporeCounter))
	sporeCounter = sporeCounter + 1
	self:Bar(args.spellId, 21.8, CL.count:format(args.spellName, sporeCounter))
end

function mod:TimberSmash(args)
	self:Message(args.spellId, "Urgent", "Alarm", args.spellName)
	self:Bar(args.spellId, 21.8)
end

function mod:ChokingVines(args)
	if self:Me(args.destGUID)then
		self:TargetMessage(236650, args.destName, "Personal", "Warning")
	end
end

function mod:FulminatingLashers(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 40.1)
end

function mod:Fixate(args)
	if self:Me(args.destGUID)then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning", args.spellName)
		self:Flash(args.spellId)
		self:Say(args.spellId)
		self:OpenProximity(args.spellId, 5)
	end
end

function mod:FixateRemoved(args)
	if self:Me(args.destGUID)then
		self:CloseProximity(args.spellId)
	end
end

function mod:SucculentLashers(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 40.1)
end

do
	local prev = 0
	function mod:ToxicSap(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(236640, "Personal", "Alert", CL.underyou:format(self:SpellName(236640)))
		end
	end
end
