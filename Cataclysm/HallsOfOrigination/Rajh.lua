-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rajh", 644, 130)
if not mod then return end
mod:RegisterEnableMob(39378)
mod.engageId = 1078
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local warnedAboutBlessingIncoming = nil

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		-2861, -- Sun Strike
		-2862, -- Summon Sun Orb
		{-2863, "FLASH"}, -- Inferno Leap
		76355, -- Blessing of the Sun
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SunStrike", 73872)
	self:Log("SPELL_AURA_APPLIED", "SummonSunOrb", 80352)
	self:Log("SPELL_AURA_APPLIED", "InfernoLeap", 87657) -- 87657 = Burning Adrenaline Rush, the debuff you get when he's targeting your location

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:SunStrike(args)
	self:Message(-2861, "Attention")
end

function mod:SummonSunOrb(args)
	self:Message(-2862, "Urgent")
end

function mod:InfernoLeap(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(-2863, args.destName, "Personal", "Warning")
		self:Flash(-2863)
	end
end

do
	function mod:UNIT_POWER(unit)
		local power = UnitPower(unit) / UnitPowerMax(unit) * 100
		if power <= 30 and not warnedAboutBlessingIncoming then
			warnedAboutBlessingIncoming = true
			self:Message(76355, "Neutral", nil, CL.soon:format(self:SpellName(76355)))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName, _, _, spellId)
	if spellId == 76352 then -- Blessing of the Sun
		self:Message(76355, "Positive", "Long", CL.casting:format(spellName))
		self:CastBar(76355, 20) -- EJ says "reenergizes himself with ... for 3 sec" but it took 17s for him to get back 100 energy when I tried, and the last SPELL_PERIODIC_ENERGIZE event fired 20s after the USCS
		self:ScheduleTimer(function() warnedAboutBlessingIncoming = nil end, 20) -- no events that indicate the end of this "phase"
	end
end
