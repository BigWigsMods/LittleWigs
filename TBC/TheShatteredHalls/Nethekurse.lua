
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Warlock Nethekurse", 710, 566)
if not mod then return end
mod:RegisterEnableMob(16807)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		30500, -- Death Coil
		30496, -- Lesser Shadow Fissure
		30502, -- Dark Spin
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DeathCoil", 30500)
	self:Log("SPELL_AURA_APPLIED", "DeathCoilApplied", 30500)
	self:Log("SPELL_DAMAGE", "ConsumptionDamage", 35951)
	self:Log("SPELL_MISSED", "ConsumptionDamage", 35951)
	self:Log("SPELL_AURA_APPLIED", "DarkSpin", 30502)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")

	self:Death("Win", 16807)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeathCoil(args)
	self:CDBar(args.spellId, 12)
end

function mod:DeathCoilApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
end

do
	local prev = 0
	function mod:ConsumptionDamage(args) -- Lesser Shadow Fissure spellcast
		local t = GetTime()
		if t-prev > 1.5 and self:Me(args.destGUID) then
			prev = t
			self:Message(30496, "Personal", "Alarm", CL.underyou:format(self:SpellName(30496)))
		end
	end
end

function mod:DarkSpin(args)
	self:Message(args.spellId, "Important", "Info", "25% - ".. args.spellName)
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 16807 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 30.5 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			self:Message(30502, "Positive", nil, CL.soon:format(self:SpellName(30502)), false)
		end
	end
end

