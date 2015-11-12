
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Lady Naz'jar", 767, 101)
if not mod then return end
mod:RegisterEnableMob(40586)

local spout1 = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		75683, -- Waterspout
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "Waterspout", 75683)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 40586)
end

function mod:OnEngage()
	spout1 = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Waterspout(args)
	self:Bar(args.spellId, 60)
	self:DelayedMessage(args.spellId, 50, CL.custom_sec:format(CL.over:format(args.spellName), 10), "Attention") -- XXX fix "!" in string
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 40586 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 69 and not spout1 then
			spout1 = true
			self:Message(75683, "Attention", nil, CL.soon:format(self:SpellName(75683)), false)
		elseif hp < 36 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
			self:Message(75683, "Attention", nil, CL.soon:format(self:SpellName(75683)), false)
		end
	end
end

