--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Warlock Nethekurse", 540, 566)
if not mod then return end
mod:RegisterEnableMob(16807)
mod:SetEncounterID(1936)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

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
	if self:Retail() then
		self:Log("SPELL_PERIODIC_DAMAGE", "ConsumptionDamage", 30498)
		self:Log("SPELL_PERIODIC_MISSED", "ConsumptionDamage", 30498)
	else -- Classic
		self:Log("SPELL_DAMAGE", "ConsumptionDamage", 35951)
		self:Log("SPELL_MISSED", "ConsumptionDamage", 35951)
	end
	self:Log("SPELL_AURA_APPLIED", "DarkSpin", 30502)

	if self:Classic() then
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeathCoil(args)
	self:CDBar(args.spellId, 12)
end

function mod:DeathCoilApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

do
	local prev = 0
	function mod:ConsumptionDamage(args) -- Lesser Shadow Fissure spellcast
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(30496, "blue", "alarm", CL.underyou:format(self:SpellName(30496)))
			end
		end
	end
end

function mod:DarkSpin(args)
	self:MessageOld(args.spellId, "red", "info", CL.percent:format(25, args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 16807 then
		local hp = self:GetHealth(unit)
		if hp < 30 then
			if self:Classic() then
				self:UnregisterEvent(event)
			else
				self:UnregisterUnitEvent(event, unit)
			end
			self:MessageOld(30502, "green", nil, CL.soon:format(self:SpellName(30502)), false) -- Dark Spin
		end
	end
end
