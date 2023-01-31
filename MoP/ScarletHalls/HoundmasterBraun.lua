
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Houndmaster Braun", 1001, 660)
if not mod then return end
mod:RegisterEnableMob(59303)

--------------------------------------------------------------------------------
-- Locals
--

local nextCallDogs = 90

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5611, -- Bloody Rage
		114259, -- Call Dog
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BloodyRage", 116140)
	self:Log("SPELL_CAST_SUCCESS", "CallDog", 114259)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59303)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH", "RageWarn", "boss1")
	nextCallDogs = 90
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallDog(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.percent:format(nextCallDogs, args.spellName))
	nextCallDogs = nextCallDogs - 10
end

function mod:BloodyRage(args)
	self:MessageOld(-5611, "yellow", "alert", CL.percent:format(50, args.spellName), args.spellId)
end

function mod:RageWarn(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(-5611, "green", "info", CL["soon"]:format(self:SpellName(116140)), false) -- Bloody Rage
	end
end

