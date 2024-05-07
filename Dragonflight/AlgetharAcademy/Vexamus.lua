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
local arcaneFissureCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Professor Maxdormu
		386544, -- Arcane Orbs
		{391977, "DISPEL"}, -- Oversurge (Mythic only)
		-- Vexamus
		388537, -- Arcane Fissure
		{386173, "SAY", "SAY_COUNTDOWN"}, -- Mana Bombs
		385958, -- Arcane Expulsion
	}, {
		["warmup"] = CL.general,
		[386544] = -25622, -- Professor Maxdormu
		[388537] = -25623, -- Vexamus
	}
end

function mod:OnBossEnable()
	-- Professor Maxdormu
	self:Log("SPELL_CAST_SUCCESS", "ArcaneOrbs", 386544)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OversurgeApplied", 391977)

	-- Vexamus
	self:Log("SPELL_CAST_START", "ArcaneFissure", 388537)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneFissureSuccess", 388537)
	self:Log("SPELL_ENERGIZE", "ArcaneOrbAbsorbed", 386088)
	self:Log("SPELL_CAST_START", "ManaBombs", 386173)
	self:Log("SPELL_AURA_APPLIED", "ManaBombApplied", 386181)
	self:Log("SPELL_AURA_REMOVED", "ManaBombRemoved", 386181)
	self:Log("SPELL_CAST_START", "ArcaneExpulsion", 385958)
end

function mod:OnEngage()
	arcaneFissureCount = 0
	-- 40 second energy gain + ~.9 seconds until energy gain is initially turned on
	arcaneFissureTime = GetTime() + 40.9
	self:CDBar(386544, 4.1) -- Arcane Orbs
	self:CDBar(385958, 12.1) -- Arcane Expulsion
	self:CDBar(386173, 22.1) -- Mana Bombs
	self:CDBar(388537, 40.9, CL.count:format(self:SpellName(388537), 1)) -- Arcane Fissure (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 19.7, CL.active, "achievement_dungeon_dragonacademy")
end

-- Professor Maxdormu

function mod:ArcaneOrbs(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	-- minimum CD is 20.7, but for each Arcane Fissure cast 3.6 seconds is added
	self:CDBar(args.spellId, 20.7)
end

function mod:OversurgeApplied(args)
	if args.amount % 2 == 0 and (self:Me(args.destGUID) or self:Dispeller("magic", false, args.spellId)) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 4)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Vexamus

function mod:ArcaneFissure(args)
	arcaneFissureCount = arcaneFissureCount + 1
	self:StopBar(CL.count:format(args.spellName, arcaneFissureCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, arcaneFissureCount))
	self:PlaySound(args.spellId, "alert")
	-- Arcane Fissure adds 3.6 seconds to all other timers
	local arcaneExpulsionTimeLeft = self:BarTimeLeft(385958)
	if arcaneExpulsionTimeLeft > .1 then
		self:CDBar(385958, {arcaneExpulsionTimeLeft + 3.6, 23.1})
	end
	local manaBombsTimeLeft = self:BarTimeLeft(386173)
	if manaBombsTimeLeft > .1 then
		self:CDBar(386173, {manaBombsTimeLeft + 3.6, 23.1})
	end
	local arcaneOrbsTimeLeft = self:BarTimeLeft(386544)
	if arcaneOrbsTimeLeft > .1 then
		self:CDBar(386544, {arcaneOrbsTimeLeft + 3.6, 20.7})
	end
end

function mod:ArcaneFissureSuccess(args)
	-- cast at 100 energy, gains 2.5 energy per second
	self:CDBar(args.spellId, 40.7, CL.count:format(self:SpellName(388537), arcaneFissureCount + 1))
	arcaneFissureTime = GetTime() + 40.7
end

function mod:ArcaneOrbAbsorbed(args)
	-- Vexamus gains 20 energy (8s worth) when it absorbs an orb
	arcaneFissureTime = arcaneFissureTime - 8
	local timeLeft = arcaneFissureTime - GetTime()
	if timeLeft > 0 then
		self:CDBar(388537, {timeLeft, 40.7}, CL.count:format(self:SpellName(388537), arcaneFissureCount + 1)) -- Arcane Fissure
	else
		self:StopBar(CL.count:format(self:SpellName(388537), arcaneFissureCount + 1)) -- Arcane Fissure
	end
end

do
	local playerList = {}

	function mod:ManaBombs(args)
		playerList = {}
		-- minimum CD is 23.1, but for each Arcane Fissure cast 3.6 seconds is added
		self:CDBar(args.spellId, 23.1)
	end

	function mod:ManaBombApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(386173, "yellow", playerList, 3)
		self:PlaySound(386173, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(386173, args.spellName, nil, "Mana Bomb")
			self:SayCountdown(386173, 4)
		end
	end

	function mod:ManaBombRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(386173)
		end
	end
end

function mod:ArcaneExpulsion(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- minimum CD is 23.1, but for each Arcane Fissure cast 3.6 seconds is added
	self:CDBar(args.spellId, 23.1)
end
