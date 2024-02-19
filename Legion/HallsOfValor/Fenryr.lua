--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fenryr", 1477, 1487)
if not mod then return end
mod:RegisterEnableMob(95674, 99868) -- Phase 1 Fenryr, Phase 2 Fenryr
mod:SetEncounterID(1807)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		196512, -- Claw Frenzy
		196543, -- Unnerving Howl
		{197558, "SAY"}, -- Ravenous Leap
		{196838, "SAY", "ICON"}, -- Scent of Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Stealth", 196567)
	self:Log("SPELL_CAST_START", "ClawFrenzy", 196512)
	self:Log("SPELL_CAST_SUCCESS", "ClawFrenzy", 196512)
	self:Log("SPELL_CAST_START", "UnnervingHowl", 196543)
	self:Log("SPELL_CAST_START", "RavenousLeap", 197558)
	self:Log("SPELL_AURA_APPLIED", "RavenousLeapApplied", 197556)
	self:Log("SPELL_CAST_START", "ScentOfBlood", 196838)
	self:Log("SPELL_AURA_REMOVED", "ScentOfBloodRemoved", 196838)
end

function mod:OnEngage()
	if self:GetBossId(95674) then -- Stage 1 Fenryr
		self:RegisterEvent("ENCOUNTER_END")
		self:SetRespawnTime(25) -- 5s shorter because of the 5s delayed bar on wipe
		self:SetStage(1)
	elseif self:GetBossId(99868) then -- Stage 2 Fenryr
		self:SetRespawnTime(30)
		self:SetStage(2)
		self:CDBar(196838, 16.9) -- Scent of Blood
	end
	self:CDBar(196543, 4.5) -- Unnerving Howl
	self:CDBar(197558, 6.0) -- Ravenous Leap
	self:CDBar(196512, 10.6) -- Claw Frenzy
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local stealthed = false

	-- Custom ENCOUNTER_END only used for stage 1, stage 2 will use normal one, replaced by :Reboot()
	function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
		if engageId == self.engageId then
			stealthed = false
			if status == 0 then
				-- wait some seconds to see if Fenryr stealths
				self:ScheduleTimer("CheckForStealth", 5)
				self:SendMessage("BigWigs_StopBars", self)
			end
		end
	end

	function mod:Stealth()
		stealthed = true
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
	end

	function mod:CheckForStealth()
		if not stealthed then
			self:Wipe()
			-- force a respawn timer
			self:SendMessage("BigWigs_EncounterEnd", self, self.engageId, self.displayName, self:Difficulty(), 5, 0)
		else
			-- reset module for Stage 2
			self:Reboot()
		end
	end
end

do
	local prev = 0
	function mod:ClawFrenzy(args)
		-- in Mythic a SPELL_CAST_START was recently added with a 1s cast, so we can alert earlier.
		-- throttle because we keep the SPELL_CAST_SUCCESS event for other difficulties.
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
			self:CDBar(args.spellId, 9.7)
			-- soonest any ability can happen after this is 3.2s
			if self:BarTimeLeft(196543) < 3.2 then -- Unnerving Howl
				self:CDBar(196543, {3.2, 27.9})
			end
			if self:BarTimeLeft(197558) < 3.2 then -- Ravenous Leap
				self:CDBar(197558, {3.2, self:GetStage() == 1 and 35.2 or 31.6})
			end
			if self:GetStage() == 2 then
				if self:BarTimeLeft(196838) < 3.2 then -- Scent of Blood
					self:CDBar(196838, {3.2, 34.1})
				end
			end
		end
	end
end

function mod:UnnervingHowl(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 27.9)
	-- soonest any ability can happen after this is 4.8s
	if self:BarTimeLeft(196512) < 4.8 then -- Claw Frenzy
		self:CDBar(196512, {4.8, 9.7})
	end
	if self:BarTimeLeft(197558) < 4.8 then -- Ravenous Leap
		self:CDBar(197558, {4.8, 31.6})
	end
	if self:GetStage() == 2 then
		if self:BarTimeLeft(196838) < 4.8 then -- Scent of Blood
			self:CDBar(196838, {4.8, 34.1})
		end
	end
end

do
	local playerList = {}

	function mod:RavenousLeap(args)
		playerList = {}
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 35.2)
		else -- Stage 2
			self:CDBar(args.spellId, 31.6)
		end
		-- soonest any ability can happen after this is 10.9s
		self:CDBar(196512, 10.9) -- Claw Frenzy
		if self:BarTimeLeft(196543) < 10.9 then -- Unnerving Howl
			self:CDBar(196543, {10.9, 27.9})
		end
		if self:GetStage() == 2 then
			if self:BarTimeLeft(196838) < 10.9 then -- Scent of Blood
				self:CDBar(196838, {10.9, 34.1})
			end
		end
	end

	function mod:RavenousLeapApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(197558, "yellow", playerList, 4)
		self:PlaySound(197558, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(197558, nil, nil, "Ravenous Leap")
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:PrimaryIcon(196838, name)
		self:TargetMessage(196838, "orange", name)
		if self:Me(guid) then
			self:Say(196838, nil, nil, "Scent of Blood")
			self:PlaySound(196838, "warning")
		end
	end

	function mod:ScentOfBlood(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 34.1)
		-- soonest any ability can happen after this is 18.2s
		self:CDBar(196512, 18.2) -- Claw Frenzy
		if self:BarTimeLeft(196543) < 18.2 then -- Unnerving Howl
			self:CDBar(196543, {18.2, 27.9})
		end
		if self:BarTimeLeft(197558) < 18.2 then -- Ravenous Leap
			self:CDBar(197558, {18.2, 31.6})
		end
	end

	function mod:ScentOfBloodRemoved(args)
		self:PrimaryIcon(args.spellId)
	end
end
