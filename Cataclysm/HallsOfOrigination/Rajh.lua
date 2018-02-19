-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Rajh", 644, 130)
if not mod then return end
mod:RegisterEnableMob(39378)

--------------------------------------------------------------------------------
-- Locals
--

local strike = 0
local blessingTime = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		73874, -- Sun Strike
		80352, -- Summon Sun Orb
		{76355, "FLASH"}, -- Blessing of the Sun
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SunStrike", 73872)
	self:Log("SPELL_AURA_APPLIED", "SummonSunOrb", 80352)
	self:Log("SPELL_AURA_APPLIED", "BlessingOfTheSun", 76355)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 39378)
end

function mod:OnEngage()
	strike = 0
	blessingTime = 0
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SunStrike(args)
	self:Message(args.spellId, "Attention")
end

function mod:SummonSunOrb(args)
	self:Message(args.spellId, "Urgent")
end

function mod:BlessingOfTheSun(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Important", "Alert")
		self:Flash(args.spellId)
		strike = strike + 1
	end
end

function mod:UNIT_POWER(unit)
	if strike == 2 then
		self:UnregisterEvent("UNIT_POWER")
		return
	end
	if UnitName(unit) == self.displayName then
		local power = UnitPower(unit) / UnitPowerMax(unit) * 100
		if power < 20 and strike < 2 then
			local t = GetTime()
			if t - blessingTime > 20 then -- massive throttling as energy fills up again, needs testing
				self:Message(76355, "Attention", nil, CL.soon:format(self:SpellName(76355)))
				blessingTime = t
			end
		end
	end
end
