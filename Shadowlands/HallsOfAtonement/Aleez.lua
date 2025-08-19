--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Adjudicator Aleez", 2287, 2411)
if not mod then return end
mod:RegisterEnableMob(165410) -- High Adjudicator Aleez
mod:SetEncounterID(2403)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local spectralProcessionCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.empty_anima_vessel = "Empty Anima Vessel"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- High Adjudicator Aleez
		{323538, "OFF"}, -- Anima Bolt
		329340, -- Anima Fountain
		1236512, -- Unstable Anima
		323743, -- Spectral Procession
		323848, -- Vessel of Atonement
		-- Ghastly Parishioner
		{323650, "ME_ONLY_EMPHASIZE"}, -- Haunting Fixation
	}, {
		[323538] = self.displayName, -- High Adjudicator Aleez
		[323650] = -21861, -- Ghastly Parishioner
	}, {
		[323848] = L.empty_anima_vessel, -- Vessel of Atonement (Empty Anima Vessel)
		[323743] = CL.add_spawning, -- Spectral Procession (Add spawning)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AnimaBolt", 323538)
	self:Log("SPELL_CAST_START", "AnimaFountain", 329340)
	self:Log("SPELL_CAST_SUCCESS", "UnstableAnima", 1236512)
	self:Log("SPELL_AURA_APPLIED", "UnstableAnimaApplied", 1236513)
	self:Log("SPELL_CAST_SUCCESS", "SpectralProcession", 323743)
	self:Log("SPELL_SUMMON", "SpectralProcessionSummon", 323597)

	-- Empty Anima Vessel
	self:Log("SPELL_CAST_SUCCESS", "VesselOfAtonement", 323749) -- misspelled in English "Vessle of Atonement"

	-- Ghastly Parishioner
	self:Log("SPELL_AURA_APPLIED", "HauntingFixation", 323650)
	self:Log("SPELL_AURA_REMOVED", "HauntingFixationRemoved", 323650)
end

function mod:OnEngage()
	spectralProcessionCount = 1
	self:CDBar(323538, 5.0) -- Anima Bolt
	if self:Mythic() then
		self:CDBar(1236512, 10.1) -- Unstable Anima
	end
	self:CDBar(323743, 17.2, CL.count:format(CL.add_spawning, spectralProcessionCount)) -- Spectral Procession
	self:CDBar(329340, 19.1) -- Anima Fountain
	self:CDBar(323848, 70.4, L.empty_anima_vessel) -- Vessel of Atonement
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AnimaBolt(args)
	local _, ready = self:Interrupter()
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 8.5)
	if ready then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:AnimaFountain(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 22.2)
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:UnstableAnima(args)
		playerList = {}
		self:CDBar(args.spellId, 15.7)
	end

	function mod:UnstableAnimaApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(1236512, "orange", playerList, 2)
		self:PlaySound(1236512, "alarm", nil, playerList)
	end
end

function mod:SpectralProcession(args)
	-- an add won't be summoned if there are no unfixated players, but it goes on cooldown anyway
	self:StopBar(CL.count:format(CL.add_spawning, spectralProcessionCount))
	spectralProcessionCount = spectralProcessionCount + 1
	self:CDBar(args.spellId, 20.7, CL.count:format(CL.add_spawning, spectralProcessionCount))
end

function mod:SpectralProcessionSummon(args)
	-- this logs as being cast by a player, but that player is not necessarily the one who will be fixated by the add
	self:Message(323743, "cyan", CL.count:format(CL.add_spawned, spectralProcessionCount - 1))
	self:PlaySound(323743, "long")
end

-- Empty Anima Vessel

do
	local timer

	function mod:VesselOfAtonementSkipped()
		-- if this timer hasn't been canceled it means the spawn was skipped and we should move onto the
		-- next possible timer.
		self:CDBar(323848, 18.5, L.empty_anima_vessel) -- 20.7s - 1.2s maximum delay - the 1s we waited
		-- this timer will drift further away from reality after 2+ skipped spawns as we compound the uncertainty,
		-- but that should be a fairly unlikely scenario in actual play.
		timer = self:ScheduleTimer("VesselOfAtonementSkipped", 21.9) -- 1s after latest possible spawn
	end

	function mod:VesselOfAtonement(args)
		if self:IsEngaged() then -- cast 4x on respawn
			-- this will only be cast if there are 0 Empty Anima Vessels spawned, not including the initial 4
			if timer then
				self:CancelTimer(timer)
			end
			-- this can spawn on top of one of the initial 4 Empty Anima Vessels, in which case alerting is pointless as both
			-- will be consumed by a single Ghastly Parishioner. unfortunately we have no way to detect if this has happened.
			self:Message(323848, "cyan", CL.spawned:format(L.empty_anima_vessel))
			self:CDBar(323848, 20.7, L.empty_anima_vessel) -- either 20.7 or 21.9
			timer = self:ScheduleTimer("VesselOfAtonementSkipped", 22.9) -- 1s after latest possible spawn
			self:PlaySound(323848, "info")
		end
	end
end

-- Ghastly Parishioner

function mod:HauntingFixation(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:HauntingFixationRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end
