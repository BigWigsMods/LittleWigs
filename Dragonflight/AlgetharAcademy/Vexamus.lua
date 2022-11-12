--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vexamus", 2526, 2509)
if not mod then return end
mod:RegisterEnableMob(194181) -- Vexamus
mod:SetEncounterID(2562)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local arcaneFissureTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Professor Maxdormu
		386544, -- Arcane Orbs
		{391977, "DISPEL"}, -- Oversurge (Mythic only)
		-- Vexamus
		388537, -- Arcane Fissure
		{386173, "SAY", "SAY_COUNTDOWN"}, -- Mana Bombs
		385958, -- Arcane Expulsion
	}, {
		[386544] = -25622, -- Professor Maxdormu
		[388537] = -25623, -- Vexamus
	}
end

function mod:OnBossEnable()
	-- Professor Maxdormu
	self:Log("SPELL_CAST_SUCCESS", "ArcaneOrbs", 386544)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OversurgeApplied", 391977)

	-- Vexamus
	--self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Log("SPELL_CAST_START", "ArcaneFissure", 388537)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneFissureSuccess", 388537)
	self:Log("SPELL_ENERGIZE", "ArcaneOrbAbsorbed", 386088)
	self:Log("SPELL_CAST_START", "ManaBombs", 386173)
	self:Log("SPELL_AURA_APPLIED", "ManaBombApplied", 386181)
	self:Log("SPELL_CAST_START", "ArcaneExpulsion", 385958)
end

function mod:OnEngage()
	self:Bar(386544, 4.1) -- Arcane Orbs
	self:CDBar(385958, 12.1) -- Arcane Expulsion
	self:CDBar(386173, 24) -- Mana Bombs
	self:CDBar(388537, 40.9) -- Arcane Fissure
	-- 40 second energy gain + .9 seconds until energy gain is initially turned on
	arcaneFissureTime = GetTime() + 40.9
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Professor Maxdormu

function mod:ArcaneOrbs(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 17)
end

function mod:OversurgeApplied(args)
	if args.amount % 2 == 0 and (self:Me(args.destGUID) or self:Dispeller("magic", false, args.spellId)) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 4)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Vexamus

-- TODO is this a more reliable way to calculate the arcane fissure timer?
--[[function mod:UNIT_POWER_UPDATE(_, unit)
	if recalculateArcaneFissure then
		-- 40 seconds between Arcane Fissure casts, cast at max Energy
		local nextArcaneFissure = ceil(40 * (1 - UnitPower(unit) / 100))
		arcaneFissureTime = GetTime() + nextArcaneFissure
		if nextArcaneFissure > 0 then
			recalculateArcaneFissure = false
			self:Bar(388537, {nextArcaneFissure, 40}) -- Arcane Fissure
		end
	end
end]]--

function mod:ArcaneFissure(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:ArcaneFissureSuccess(args)
	-- Cast at 100 energy, gains 2.5 energy per second
	self:Bar(args.spellId, 40.7)
	arcaneFissureTime = GetTime() + 40.7
end

function mod:ArcaneOrbAbsorbed(args)
	-- Vexamus gains 20 energy (8s worth) when it absorbs an orb
	arcaneFissureTime = arcaneFissureTime - 8
	local timeLeft = arcaneFissureTime - GetTime()
	if timeLeft > 0 then
		self:Bar(388537, {timeLeft, 40.7}) -- Arcane Fissure
	else
		self:StopBar(388537) -- Arcane Fissure
	end
end

do
	local playerList = {}

	function mod:ManaBombs(args)
		playerList = {}
		self:CDBar(args.spellId, 23)
	end

	function mod:ManaBombApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(386173, "yellow", playerList, 3)
		self:PlaySound(386173, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(386173, args.spellName)
			self:SayCountdown(386173, 4, args.spellName)
		end
	end
end

function mod:ArcaneExpulsion(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 19.4) -- either 19.4 or 23.1, usually alternating
end
