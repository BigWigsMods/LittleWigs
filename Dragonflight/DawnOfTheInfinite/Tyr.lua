--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tyr, the Infinite Keeper", 2579, 2526)
if not mod then return end
mod:RegisterEnableMob(198998) -- Tyr, the Infinite Keeper
mod:SetEncounterID(2670)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local siphonOathstoneCount = 1
local abilitiesUntilRecharge = 4

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- Stage 1: Infinite Hand Technique
		401248, -- Titanic Blow
		401482, -- Infinite Annihilation
		400641, -- Dividing Strike
		408183, -- Titanic Empowerment
		{400681, "SAY"}, -- Spark of Tyr
		-- Stage 2: Siphon Oathstone
		{400642, "CASTBAR"}, -- Siphon Oathstone
		406543, -- Stolen Time
	}, {
		["warmup"] = CL.general,
		[401248] = 404296, -- Infinite Hand Technique
		[400642] = 400642, -- Siphon Oathstone
	}
end

function mod:OnBossEnable()
	-- Stage 1: Infinite Hand Technique
	self:Log("SPELL_CAST_START", "TitanicBlow", 401248)
	self:Log("SPELL_CAST_START", "InfiniteAnnihilation", 401482)
	self:Log("SPELL_CAST_START", "DividingStrike", 400641)
	self:Log("SPELL_AURA_APPLIED", "TitanicEmpowermentApplied", 408183)
	self:Log("SPELL_AURA_APPLIED_DOSE", "TitanicEmpowermentApplied", 408183)
	self:Log("SPELL_CAST_SUCCESS", "SparkOfTyr", 400649)
	self:Log("SPELL_AURA_APPLIED", "SparkOfTyrApplied", 400681)

	-- Stage 2: Siphon Oathstone
	self:Log("SPELL_CAST_SUCCESS", "SiphonOathstone", 400642)
	self:Log("SPELL_AURA_REMOVED", "SiphonOathstoneRemoved", 400642)
	self:Log("SPELL_AURA_APPLIED", "StolenTimeApplied", 406543)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StolenTimeApplied", 406543)
	-- TODO barrier empowered?
end

function mod:OnEngage()
	siphonOathstoneCount = 1
	abilitiesUntilRecharge = 4
	self:SetStage(1)
	self:CDBar(400681, 6.0) -- Spark of Tyr
	self:CDBar(401248, 12.5) -- Titanic Blow
	self:CDBar(400641, 12.5) -- Dividing Strike
	self:CDBar(401482, 12.5) -- Infinite Annihilation
	self:CDBar(400642, 46.1, CL.count:format(self:SpellName(400642), siphonOathstoneCount)) -- Siphon Oathstone
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup()
	-- triggered from trash module
	-- 15:14:41 [CLEU] SPELL_AURA_REMOVED#Creature-0-5773-2579-1018-198998-000029B459#Tyr, the Infinite Keeper#Creature-0-5773-2579-1018-198998-000029B459#Tyr, the Infinite Keeper#413595#Pondering the Oathstone#BUFF#nil
	-- 15:15:15 [NAME_PLATE_UNIT_ADDED] Tyr, the Infinite Keeper#Creature-0-5773-2579-1018-198998-000029B459
	self:Bar("warmup", 34, CL.active, "achievement_dungeon_dawnoftheinfinite")
end

-- Stage 1: Infinite Hand Technique

function mod:TitanicBlow(args)
	abilitiesUntilRecharge = abilitiesUntilRecharge - 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if abilitiesUntilRecharge >= 2 then
		-- same ability is never cast twice in a row, so only show the bar
		-- if there are at least 2 abilities left in the phase.
		self:CDBar(args.spellId, 16.0)
	else
		self:StopBar(args.spellId)
	end
	if abilitiesUntilRecharge >= 1 then
		-- minimum of 8s until Infinite Annihilation or Dividing Strike
		if self:BarTimeLeft(401482) < 8.0 then -- Infinite Annihilation
			self:CDBar(401482, 8.0)
		end
		if self:BarTimeLeft(400641) < 8.0 then -- Dividing Strike
			self:CDBar(400641, 8.0)
		end
	else
		self:StopBar(401482) -- Infinite Annihiliation
		self:StopBar(400641) -- Dividing Strike
	end
end

function mod:InfiniteAnnihilation(args)
	abilitiesUntilRecharge = abilitiesUntilRecharge - 1
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if abilitiesUntilRecharge >= 2 then
		-- same ability is never cast twice in a row, so only show the bar
		-- if there are at least 2 abilities left in the phase.
		self:CDBar(args.spellId, 16.0)
	else
		self:StopBar(args.spellId)
	end
	if abilitiesUntilRecharge >= 1 then
		-- minimum of 8s until Titanic Blow or Dividing Strike
		if self:BarTimeLeft(401248) < 8.0 then -- Titanic Blow
			self:CDBar(401248, 8.0)
		end
		if self:BarTimeLeft(400641) < 8.0 then -- Dividing Strike
			self:CDBar(400641, 8.0)
		end
	else
		self:StopBar(401248) -- Titanic Blow
		self:StopBar(400641) -- Dividing Strike
	end
end

function mod:DividingStrike(args)
	abilitiesUntilRecharge = abilitiesUntilRecharge - 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	if abilitiesUntilRecharge >= 2 then
		-- same ability is never cast twice in a row, so only show the bar
		-- if there are at least 2 abilities left in the phase.
		self:CDBar(args.spellId, 16.0)
	else
		self:StopBar(args.spellId)
	end
	if abilitiesUntilRecharge >= 1 then
		-- minimum of 8s until Titanic Blow or Infinite Annihilation
		if self:BarTimeLeft(401248) < 8.0 then -- Titanic Blow
			self:CDBar(401248, 8.0)
		end
		if self:BarTimeLeft(401482) < 8.0 then -- Infinite Annihilation
			self:CDBar(401482, 8.0)
		end
	else
		self:StopBar(401248) -- Titanic Blow
		self:StopBar(401482) -- Infinite Annihiliation
	end
end

function mod:TitanicEmpowermentApplied(args)
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "warning")
end

do
	local playerList = {}

	function mod:SparkOfTyr(args)
		playerList = {}
		self:StopBar(400681)
	end

	function mod:SparkOfTyrApplied(args)
		playerList[#playerList + 1] = args.destName
		-- debuff has some travel time, so wait extra long for the 2nd target
		self:TargetsMessage(args.spellId, "red", playerList, 2, nil, nil, 0.6)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end

-- Stage 2: Siphon Oathstone

function mod:SiphonOathstone(args)
	self:StopBar(CL.count:format(args.spellName, siphonOathstoneCount))
	self:StopBar(400681) -- Spark of Tyr
	self:StopBar(401248) -- Titanic Blow
	self:StopBar(400641) -- Dividing Strike
	self:StopBar(401482) -- Infinite Annihilation
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, siphonOathstoneCount))
	self:PlaySound(args.spellId, "long")
	siphonOathstoneCount = siphonOathstoneCount + 1
	-- cast at 0 energy, during Siphon Oathstone channel he charges back to 100 energy
	-- each of Titanic Blow, Infinite Annihilation, and Dividing Strike cost 25 energy
	self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, siphonOathstoneCount))
	-- 15s channel - TODO can end early if you break shield?
	self:CastBar(args.spellId, 15)
end

function mod:SiphonOathstoneRemoved(args)
	abilitiesUntilRecharge = 4
	self:StopBar(CL.cast:format(args.spellName))
	self:SetStage(1)
	self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CDBar(400681, 8.0) -- Spark of Tyr
	self:CDBar(401248, 12.5) -- Titanic Blow
	self:CDBar(400641, 12.5) -- Dividing Strike
	self:CDBar(401482, 12.5) -- Infinite Annihilation
end

function mod:StolenTimeApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 5)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end
