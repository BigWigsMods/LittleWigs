--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Houndmaster Braun", 1001, 660)
if not mod then return end
mod:RegisterEnableMob(59303)
mod:SetEncounterID(1422)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local nextCallDogs = 90

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		116140, -- Bloody Rage
		114259, -- Call Dog
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BloodyRage", 116140)
	self:Log("SPELL_CAST_SUCCESS", "CallDog", 114259)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH", "RageWarn", "boss1")
	nextCallDogs = 90
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:CallDog(args)
		local t = args.time
		if t - prev > 3 then
			-- throttle the alert in case you are overleveled
			prev = t
			self:Message(args.spellId, "orange", CL.percent:format(nextCallDogs, args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		nextCallDogs = nextCallDogs - 10
	end
end

function mod:BloodyRage(args)
	self:Message(args.spellId, "yellow", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:RageWarn(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		if hp > 40 then
			self:Message(116140, "green", CL.soon:format(self:SpellName(116140))) -- Bloody Rage
			self:PlaySound(116140, "info")
		end
	end
end
