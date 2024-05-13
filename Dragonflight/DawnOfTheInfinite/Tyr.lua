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
local infiniteHandCastCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_ulduarraid_titan_01"
end

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
end

function mod:OnEngage()
	siphonOathstoneCount = 1
	infiniteHandCastCount = 1
	self:StopBar(CL.active) -- Warmup
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
	self:Bar("warmup", 34, CL.active, L.warmup_icon)
end

-- Stage 1: Infinite Hand Technique

do
	local firstInfiniteHandCast = nil

	function mod:TitanicBlow(args)
		self:StopBar(args.spellId)
		self:Message(args.spellId, "purple", CL.count_amount:format(args.spellName, infiniteHandCastCount, 4))
		self:PlaySound(args.spellId, "alarm")
		infiniteHandCastCount = infiniteHandCastCount + 1
		if infiniteHandCastCount == 2 then
			-- the first ability in the sequence will not be cast again. since Dividing Strike will never be the
			-- second cast, we know the full sequence aleady:
			-- Titanic Blow -> Infinite Annihilation -> Dividing Strike -> Infinite Annihilation
			self:CDBar(401482, 8.0) -- Infinite Annihilation
			self:CDBar(400641, 16.0) -- Dividing Strike
		elseif infiniteHandCastCount == 3 then
			-- the second ability in the sequence will be the fourth ability as well
			self:CDBar(args.spellId, 16.0)
			-- the ability which was not the first or second ability will be the third ability.
			-- we only need to start the timer for it if the first ability was Dividing Strike.
			if firstInfiniteHandCast == 400641 then -- Dividing Strike
				self:CDBar(401482, 8.0) -- Infinite Annihilation
				firstInfiniteHandCast = nil
			end
		end
	end

	function mod:InfiniteAnnihilation(args)
		self:StopBar(args.spellId)
		self:Message(args.spellId, "orange", CL.count_amount:format(args.spellName, infiniteHandCastCount, 4))
		self:PlaySound(args.spellId, "alarm")
		infiniteHandCastCount = infiniteHandCastCount + 1
		if infiniteHandCastCount == 2 then
			-- the first ability in the sequence will not be cast again. since Dividing Strike will never be the
			-- second cast, we know the full sequence aleady:
			-- Infinite Annihilation -> Titanic Blow -> Dividing Strike -> Titanic Blow
			self:CDBar(401248, 8.0) -- Titanic Blow
			self:CDBar(400641, 16.0) -- Dividing Strike
		elseif infiniteHandCastCount == 3 then
			-- the second ability in the sequence will be the fourth ability as well
			self:CDBar(args.spellId, 16.0)
			-- the ability which was not the first or second ability will be the third ability.
			-- we only need to start the timer for it if the first ability was Dividing Strike.
			if firstInfiniteHandCast == 400641 then -- Dividing Strike
				self:CDBar(401248, 8.0) -- Titanic Blow
				firstInfiniteHandCast = nil
			end
		end
	end

	function mod:DividingStrike(args)
		self:StopBar(args.spellId)
		self:Message(args.spellId, "yellow", CL.count_amount:format(args.spellName, infiniteHandCastCount, 4))
		self:PlaySound(args.spellId, "alert")
		infiniteHandCastCount = infiniteHandCastCount + 1
		-- Dividing Strike can only be the first or third ability
		if infiniteHandCastCount == 2 then
			-- if Dividing Strike is the first ability there are two possible combinations:
			-- Dividing Strike -> Titanic Blow -> Infinite Annihilation -> Titanic Blow
			-- Dividing Strike -> Infinite Annihilation -> Titanic Blow -> Infinite Annihilation
			firstInfiniteHandCast = args.spellId
			self:CDBar(401248, 8.0) -- Titanic Blow
			self:CDBar(401482, 8.0) -- Infinite Annihilation
		end
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
			self:Say(args.spellId, nil, nil, "Spark of Tyr")
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
	-- 15s channel
	self:CastBar(args.spellId, 15)
end

function mod:SiphonOathstoneRemoved(args)
	infiniteHandCastCount = 1
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
