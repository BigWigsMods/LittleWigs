local isTenDotTwo = select(4, GetBuildInfo()) >= 100200 --- XXX delete when 10.2 is live everywhere
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ozumat", 643, 104)
if not mod then return end
mod:RegisterEnableMob(
	40792,  -- Neptulon
	213770, -- Ink of Ozumat
	44566   -- Ozumat
)
mod:SetEncounterID(1047)
mod:SetRespawnTime(41.5) -- 30s for Neptulon then 11.5s for Ink of Ozumat
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local putridRoarCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Ink of Ozumat
		{428407, "SAY"}, -- Blotting Barrage
		428868, -- Putrid Roar
		428530, -- Murk Spew
		{428889, "TANK"}, -- Foul Bolt
		-- Neptulon
		428668, -- Cleansing Flux
		-- Ozumat
		428594, -- Deluge of Filth
	}, {
		[428407] = -28235, -- Ink of Ozumat
		[428668] = -28246, -- Neptulon
		[428594] = -28238, -- Ozumat
	}
end

function mod:OnBossEnable()
	-- TODO intial RP? probably from trash module
	-- "<0.77 01:31:41> [CHAT_MSG_MONSTER_SAY] The beast has returned! It must not pollute my waters!#Neptulon###Delko##0#0##0#146#nil#0#false#false#false#false", -- [2]
	-- "<12.05 01:31:53> [NAME_PLATE_UNIT_ADDED] Ink of Ozumat#Creature-0-5770-643-4692-213770-00001F9BC6", -- [10]

	if isTenDotTwo then
		-- Stages
		self:Death("InkOfOzumatDeath", 213770)

		-- Ink of Ozumat
		self:Log("SPELL_CAST_START", "BlottingBarrage", 428401)
		self:Log("SPELL_AURA_APPLIED", "BlottingBarrageApplied", 428407)
		self:Log("SPELL_CAST_START", "PutridRoar", 428868)
		self:Log("SPELL_CAST_START", "MurkSpew", 428530)
		self:Log("SPELL_CAST_START", "FoulBolt", 428889)

		-- Neptulon
		self:Log("SPELL_CAST_SUCCESS", "CleansingFlux", 428674)
		self:Log("SPELL_AURA_APPLIED", "CleansingFluxApplied", 428668)

		-- Ozumat
		self:Log("SPELL_CAST_SUCCESS", "DelugeOfFilth", 428594)
	else
		-- XXX delete these listeners when 10.2 is live everywhere
		self:Log("SPELL_CAST_SUCCESS", "EntanglingGrasp", 83463) -- Entangling Grasp, 3 adds that need to be killed in P2 cast this on Neptulon
		self:Log("SPELL_AURA_REMOVED", "EntanglingGraspRemoved", 83463)
		self:Log("SPELL_CAST_SUCCESS", "TidalSurge", 76133) -- the buff Neptulon applies to players in P3
	end
end

function mod:OnEngage()
	putridRoarCount = 1
	self:SetStage(1)
	self:CDBar(428407, 5.1) -- Blotting Barrage
	self:CDBar(428530, 10.7) -- Murk Spew
	self:CDBar(428668, 15.0) -- Cleansing Flux
	self:CDBar(428594, 20.8) -- Deluge of Filth
	self:CDBar(428868, 25.3, CL.count:format(self:SpellName(428868), putridRoarCount)) -- Putrid Roar
end

-- TODO delete the block below when 10.2 is live everywhere
if not isTenDotTwo then
	function mod:GetOptions()
		return {
			"stages",
		}
	end
	function mod:OnEngage()
		self:SetStage(1)
		-- this stage lasts 1:40 on both difficulties, EJ's entry is incorrect
		self:Bar("stages", 100, CL.stage:format(1), "Achievement_Dungeon_Throne of the Tides") -- Yes, " " is the correct delimiter.
		self:DelayedMessage("stages", 90, "cyan", CL.soon:format(CL.stage:format(2)))
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:InkOfOzumatDeath(args)
	self:StopBar(428407) -- Blotting Barrage
	self:StopBar(CL.count:format(self:SpellName(428868), putridRoarCount)) -- Putrid Roar
	self:StopBar(428530) -- Murk Spew
	self:StopBar(428668) -- Cleansing Flux
	self:StopBar(428594) -- Deluge of Filth
	self:SetStage(2)
	self:Message("stages", "cyan", -2219, 76133) -- Stage 2: Tidal Surge, Tidal Surge
	self:PlaySound("stages", "long")
end

-- Ink of Ozumat

do
	local playerList = {}

	function mod:BlottingBarrage(args)
		playerList = {}
		self:CDBar(428407, 30.3)
	end

	function mod:BlottingBarrageApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end

function mod:PutridRoar(args)
	self:StopBar(CL.count:format(args.spellName, putridRoarCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, putridRoarCount))
	self:PlaySound(args.spellId, "alert")
	putridRoarCount = putridRoarCount + 1
	self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, putridRoarCount))
end

function mod:MurkSpew(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 32.7)
end

function mod:FoulBolt(args)
	-- only cast when the tank is out of melee range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end

-- Neptulon

do
	local playerList = {}

	function mod:CleansingFlux(args)
		playerList = {}
		self:CDBar(428668, 30.3)
	end

	function mod:CleansingFluxApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "green", playerList, 2)
		self:PlaySound(args.spellId, "info", nil, playerList)
	end
end

-- Ozumat

function mod:DelugeOfFilth(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.3)
end

-- TODO delete the block below when 10.2 is live everywhere
if not isTenDotTwo then
	function mod:TidalSurge()
		self:SetStage(3)
		self:MessageOld("stages", "cyan", "long", CL.stage:format(3), false)
	end
	do
		local prev, addsAlive = 0, 0
		function mod:EntanglingGrasp()
			addsAlive = addsAlive + 1
			local t = GetTime()
			if t-prev > 10 then
				prev = t
				self:SetStage(2)
				self:MessageOld("stages", "cyan", "long", CL.stage:format(2), false)
			end
		end
		function mod:EntanglingGraspRemoved()
			addsAlive = addsAlive - 1
			self:MessageOld("stages", "cyan", nil, CL.add_remaining:format(addsAlive), false)
		end
	end
end
