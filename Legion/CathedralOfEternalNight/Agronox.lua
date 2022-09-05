
--------------------------------------------------------------------------------
-- TODO List:
-- - Check Fulminating and Succulent Lasher timers after the first sets

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Agronox", 1677, 1905)
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
		{238674, "FLASH"}, -- Fixate
		236639, -- Succulent Lashers
		236640, -- Toxic Sap
	},{
		[236524] = "general",
		[236527] = CL.adds,
		[236639] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("RAID_BOSS_WHISPER") -- Fulminating Lashers: Fixate (no spell_aura_applied event)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "PoisonousSpores", 236524) -- Poisonous Spores
	self:Log("SPELL_CAST_START", "TimberSmash", 235751) -- Timber Smash
	self:Log("SPELL_AURA_APPLIED", "ChokingVines", 238598) -- Choking Vines
	self:Log("SPELL_CAST_SUCCESS", "FulminatingLashers", 236527) -- Fulminating Lashers
	self:Log("SPELL_CAST_SUCCESS", "SucculentLashers", 236639) -- Succulent Lashers

	-- Toxic Sap // Succulent Secretion
	self:Log("SPELL_AURA_APPLIED", "ToxicSap", 240063, 240065) -- Succulent Secretion x2
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicSap", 240063, 240065) -- Succulent Secretion x2
	self:Log("SPELL_PERIODIC_MISSED", "ToxicSap", 240063, 240065) -- Succulent Secretion x2

end

function mod:OnEngage()
	sporeCounter = 1

	self:Bar(235751, 6.2) -- Timber Smash
	self:Bar(236524, 13.1, CL.count:format(self:SpellName(236524), sporeCounter)) -- Poisonous Spores
	self:Bar(236527, 11) -- Fulminating Lashers
	if self:Mythic() then
		self:Bar(236639, 19.2) -- Succulent Lashers
	end
	self:Bar(236650, 24.4) -- Choking Vines
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:RAID_BOSS_WHISPER(_, msg)
	if msg:find("238674", nil, true) then -- Fixates
		self:MessageOld(238674, "blue", "alarm", CL.you:format(self:SpellName(238674)))
		self:Flash(238674)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 236650 then -- Choking Vines
		self:MessageOld(236650, "yellow", "alert", spellId, 236650)
		self:Bar(236650, 40.1)
	end
end

function mod:PoisonousSpores(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.count:format(args.spellName, sporeCounter))
	sporeCounter = sporeCounter + 1
	self:Bar(args.spellId, 21.1, CL.count:format(args.spellName, sporeCounter))
end

function mod:TimberSmash(args)
	self:MessageOld(args.spellId, "orange", "alarm", args.spellName)
	self:Bar(args.spellId, 21.8)
end

function mod:ChokingVines(args)
	if self:Me(args.destGUID)then
		self:TargetMessageOld(236650, args.destName, "blue", "warning")
	end
end

function mod:FulminatingLashers(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 40.1)
end

function mod:SucculentLashers(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 40.1)
end

do
	local prev = 0
	function mod:ToxicSap(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(236640, "blue", "alert", CL.underyou:format(self:SpellName(236640)))
			end
		end
	end
end
