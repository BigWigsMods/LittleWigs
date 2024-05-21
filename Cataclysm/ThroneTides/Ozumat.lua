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
mod:SetRespawnTime(mod:Classic() and 26 or 41.5) -- 30s for Neptulon then 11.5s for Ink of Ozumat
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local putridRoarCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."
	L.custom_on_autotalk_icon = "ui_chat"
	L.warmup_icon = "achievement_dungeon_throne of the tides"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		-- Ink of Ozumat
		{428407, "SAY"}, -- Blotting Barrage
		428404, -- Blotting Darkness
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
	-- Stages
	self:Death("InkOfOzumatDeath", 213770)

	-- Ink of Ozumat
	self:Log("SPELL_CAST_START", "BlottingBarrage", 428401)
	self:Log("SPELL_AURA_APPLIED", "BlottingBarrageApplied", 428407)
	self:Log("SPELL_AURA_REMOVED", "BlottingBarrageRemoved", 428407)
	-- do not register AURA_APPLIED or PERIODIC_MISSED for Blotting Darkness, those events
	-- are expected when you have Cleansing Flux.
	self:Log("SPELL_PERIODIC_DAMAGE", "BlottingDarknessDamage", 428404)
	self:Log("SPELL_CAST_START", "PutridRoar", 428868)
	self:Log("SPELL_CAST_START", "MurkSpew", 428530)
	self:Log("SPELL_CAST_START", "FoulBolt", 428889)

	-- Neptulon
	self:Log("SPELL_CAST_SUCCESS", "CleansingFlux", 428674)
	self:Log("SPELL_AURA_APPLIED", "CleansingFluxApplied", 428668, 431368) -- first player, second player

	-- Ozumat
	self:Log("SPELL_CAST_SUCCESS", "DelugeOfFilth", 428594)
end

function mod:OnEngage()
	putridRoarCount = 1
	self:StopBar(CL.active) -- Warmup
	self:SetStage(1)
	self:CDBar(428407, 5.7) -- Blotting Barrage
	self:CDBar(428530, 10.6) -- Murk Spew
	self:CDBar(428668, 15.0) -- Cleansing Flux
	self:CDBar(428868, 18.2, CL.count:format(self:SpellName(428868), putridRoarCount)) -- Putrid Roar
	self:CDBar(428594, 20.6) -- Deluge of Filth
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			"custom_on_autotalk",
			"stages",
		}
	end

	function mod:OnBossEnable()
		self:RegisterEvent("GOSSIP_SHOW")
		self:Log("SPELL_CAST_SUCCESS", "EntanglingGrasp", 83463) -- Entangling Grasp, 3 adds that need to be killed in P2 cast this on Neptulon
		self:Log("SPELL_AURA_REMOVED", "EntanglingGraspRemoved", 83463)
		self:Log("SPELL_CAST_SUCCESS", "TidalSurge", 76133) -- the buff Neptulon applies to players in P3
	end

	function mod:OnEngage()
		self:SetStage(1)
		-- this stage lasts 1:40 on both difficulties, EJ's entry is incorrect
		self:Bar("stages", 100, CL.stage:format(1), L.warmup_icon)
		self:DelayedMessage("stages", 90, "cyan", CL.soon:format(CL.stage:format(2)))
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup()
	-- triggered from trash module on CHAT_MSG_MONSTER_SAY
	-- 0.77 [CHAT_MSG_MONSTER_SAY] The beast has returned! It must not pollute my waters!#Neptulon
	-- 12.05 [NAME_PLATE_UNIT_ADDED] Ink of Ozumat
	self:Bar("warmup", 11.3, CL.active, L.warmup_icon)
end

-- Stages

function mod:InkOfOzumatDeath(args)
	self:StopBar(428407) -- Blotting Barrage
	self:StopBar(CL.count:format(self:SpellName(428868), putridRoarCount)) -- Putrid Roar
	self:StopBar(428530) -- Murk Spew
	self:StopBar(428668) -- Cleansing Flux
	self:StopBar(428594) -- Deluge of Filth
	self:SetStage(2)
	self:Message("stages", "cyan", -2219, 76133) -- Stage Two: Tidal Surge, Tidal Surge
	self:PlaySound("stages", "long")
end

-- Ink of Ozumat

do
	local playerList = {}

	function mod:BlottingBarrage(args)
		playerList = {}
		self:CDBar(428407, 35.2)
	end

	function mod:BlottingBarrageApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Blotting Barrage")
		end
	end
end

do
	local prev = 0

	function mod:BlottingBarrageRemoved(args)
		if self:Me(args.destGUID) then
			-- Blotting Darkness spawns under each player that Blotting Barrage is removed from.
			-- give some time to run out of Blotting Darkness by resetting prev here.
			prev = args.time
		end
	end

	function mod:BlottingDarknessDamage(args)
		local t = args.time
		-- suppress alerts for the tank, who is not allowed to leave melee range
		if not self:Tank() and self:Me(args.destGUID) and t - prev > 2.1 then
			prev = t
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou", nil, args.destName)
		end
	end
end

function mod:PutridRoar(args)
	self:StopBar(CL.count:format(args.spellName, putridRoarCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, putridRoarCount))
	self:PlaySound(args.spellId, "alert")
	putridRoarCount = putridRoarCount + 1
	self:CDBar(args.spellId, 35.2, CL.count:format(args.spellName, putridRoarCount))
end

function mod:MurkSpew(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 37.6)
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
		self:CDBar(428668, 35.2)
	end

	function mod:CleansingFluxApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(428668, "info", nil, playerList)
		self:TargetsMessage(428668, "green", playerList, 2)
	end
end

-- Ozumat

function mod:DelugeOfFilth(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.2)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 40792 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1, true) -- auto confirm it
		end
	end
end

function mod:TidalSurge()
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3), false)
	self:PlaySound("stages", "long")
end

do
	local prev, addsAlive = 0, 0
	function mod:EntanglingGrasp(args)
		addsAlive = addsAlive + 1
		local t = args.time
		if t - prev > 10 then
			prev = t
			self:SetStage(2)
			self:Message("stages", "cyan", CL.stage:format(2), false)
			self:PlaySound("stages", "long")
		end
	end

	function mod:EntanglingGraspRemoved()
		addsAlive = addsAlive - 1
		self:Message("stages", "cyan", CL.add_remaining:format(addsAlive), false)
	end
end
