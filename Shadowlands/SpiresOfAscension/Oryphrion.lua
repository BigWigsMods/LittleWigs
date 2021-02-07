--------------------------------------------------------------------------------
-- TODO:
-- - Mythic Abilties
-- - Improve timers

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oryphrion", 2285, 2414)
if not mod then return end
mod:RegisterEnableMob(162060) -- Oryphrion
mod.engageId = 2358
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local prevEnergy = 100

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.early_intermission_over = "Intermission Over (%d |4orb:orbs; reached)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		324046, -- Recharge Anima
		324427, -- Empyreal Ordnance
		{334053, "SAY"}, -- Purifying Blast
		324608, -- Charged Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DrainedApplied", 323878)
	self:Log("SPELL_AURA_REMOVED", "DrainedApplied", 323878)
	self:Log("SPELL_CAST_SUCCESS", "OverchargeAnima", 324307) -- an orb reached the boss during the intermission
	self:Log("SPELL_AURA_APPLIED", "RechargeAnima", 324046)
	self:Log("SPELL_CAST_START", "EmpyrealOrdnance", 324427)
	self:Log("SPELL_CAST_START", "PurifyingBlast", 334053)
	self:Log("SPELL_CAST_START", "ChargedStomp", 324608)

	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	prevEnergy = 100

	self:Bar(334053, 8.5) -- Purifying Blast
	self:Bar(324427, 17) -- Empyreal Ordnance
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local orbsReached, intermissionEnds = 0, 0
	function mod:DrainedApplied(args)
		orbsReached = 0
		intermissionEnds = args.time + 23.2

		self:Message("stages", "green", CL.intermission, false)
		self:PlaySound("stages", "long")

		self:Bar("stages", 23.2, CL.over:format(CL.intermission), args.spellId)
		self:StopBar(324427) -- Empyreal Ordnance
		self:StopBar(334053) -- Purifying Blast
	end

	function mod:DrainedRemoved()
		if orbsReached > 0 then
			self:Message("stages", "orange", L.early_intermission_over:format(orbsReached), false)
		else
			self:Message("stages", "orange", CL.over:format(CL.intermission), false)
		end
		self:PlaySound("stages", "long")

		self:StopBar(CL.over:format(CL.intermission))
		self:Bar(334053, 9) -- Purifying Blast
		self:Bar(324427, 17.1) -- Empyreal Ordnance
	end

	function mod:OverchargeAnima(args)
		orbsReached = orbsReached + 1
		intermissionEnds = intermissionEnds - 1

		local timeLeft = intermissionEnds - args.time
		if timeLeft > 0 then
			self:Bar("stages", timeLeft, CL.over:format(CL.intermission), 323878) -- Drained
		end
	end
end

function mod:RechargeAnima(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EmpyrealOrdnance(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 26)
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(334053)
			self:PlaySound(334053, "warning")
		end
		self:TargetMessage(334053, "red", name)
	end

	function mod:PurifyingBlast(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 13)
	end
end

function mod:ChargedStomp(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:UNIT_POWER_FREQUENT(_, unit, powerType)
	if powerType ~= "ENERGY" then return end

	local current = UnitPower(unit, 3) -- ENERGY = 3
	if current < prevEnergy and current == 10 then
		self:Message("stages", "cyan", CL.soon:format(self:SpellName(323878)), false) -- Drained Soon
		self:PlaySound("stages", "info")
	elseif current > prevEnergy and current == 80 then
		self:Message("stages", "cyan", CL.soon:format(self:SpellName(232880)), false) -- Fully Charged Soon
		self:PlaySound("stages", "info")
	end

	prevEnergy = current
end
