if not BigWigsLoader.isNext then return end -- 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Writhing Coil", 2993, 2879)
if not mod then return end
mod:SetEncounterID(3457)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1299080, sound = "none"}, -- Death Rattle
	{1300503, sound = "warning"}, -- Spiteful Hunt
})
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local synchronizedVenomCount = 1
local tailScytheCount = 1
local preparingToxinCount = 1
local toxicAtrophyRemaining = 3
local vindictiveOnslaughtCount = 1
local vindictiveOnslaughtRemaining = 0
local burrowingChargeCount = 1
local venomJetCount = 1
local deathRattleCount = 1
local toxicAtrophyCount = 1
local assimilationCount = 1
local count10 = 1
local count20 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1299154] = {1299154}, -- Synchronized Venom
	[1298949] = {1298949}, -- Tail Scythe
	[1310357] = {1310357}, -- Preparing Toxin
	[1310547] = {1310547}, -- Toxic Atrophy
	[1299940] = {1299940}, -- Vindictive Onslaught
	[1299130] = {1299130}, -- Burrowing Charge
	[1300044] = {1300044}, -- Venom Jet
	[1299053] = {1299053}, -- Death Rattle
	[1310358] = {1310358}, -- Toxic Atrophy
	[1300686] = {1300686}, -- Assimilation
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- The Writhing Coil (Stage 1)
		1299154, -- Synchronized Venom
		{1298949, "TANK"}, -- Tail Scythe
		1310357, -- Preparing Toxin
		1310547, -- Toxic Atrophy
		1299940, -- Vindictive Onslaught
		1299130, -- Burrowing Charge
		1300044, -- Venom Jet
		1299053, -- Death Rattle
		-- The Uncoiled Writhe (Stage 2)
		1310358, -- Toxic Atrophy
		1300686, -- Assimilation
	}, {
		[1299154] = CL.stage:format(1),
		[1310358] = CL.stage:format(2),
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	synchronizedVenomCount = 1
	tailScytheCount = 1
	preparingToxinCount = 1
	toxicAtrophyRemaining = 3
	vindictiveOnslaughtCount = 1
	vindictiveOnslaughtRemaining = 0
	burrowingChargeCount = 1
	venomJetCount = 1
	deathRattleCount = 1
	toxicAtrophyCount = 1
	assimilationCount = 1
	count10 = 1
	count20 = 1
	activeBars = {}
	backupBars = {}
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnBossDisable()
	for eventID in next, backupBars do
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 1 or (duration == 10 and count10 % 2 == 0) then -- Synchronized Venom
		barInfo = self:SynchronizedVenomTimeline(eventInfo)
	elseif duration == 11 or (duration == 20 and count20 % 2 == 0) then -- Tail Scythe
		barInfo = self:TailScytheTimeline(eventInfo)
	elseif duration == 18 or duration == 27 then -- Preparing Toxin
		barInfo = self:PreparingToxinTimeline(eventInfo)
	elseif duration == 34 or duration == 43 then -- Vindictive Onslaught
		barInfo = self:VindictiveOnslaughtTimeline(eventInfo)
	elseif duration == 44 or duration == 53 then -- Death Rattle
		barInfo = self:DeathRattleTimeline(eventInfo)
	elseif (duration == 10 and count10 % 2 == 1) then -- Toxic Atrophy
		barInfo = self:ToxicAtrophyTimeline(eventInfo)
	elseif (duration == 20 and count20 % 2 == 1) then -- Assimilation
		barInfo = self:AssimilationTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 10 then
		count10 = count10 + 1
	end
	if duration == 20 then
		count20 = count20 + 1
	end
	if barInfo then
		activeBars[eventInfo.id] = barInfo
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Active
			self:ResumeBar(barInfo.key, barInfo.msg)
		elseif state == 1 then -- Paused
			self:PauseBar(barInfo.key, barInfo.msg)
		elseif state == 2 then -- Finished
			self:StopBar(barInfo.msg)
			if barInfo.callback then
				barInfo.callback()
			end
			activeBars[eventID] = nil
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			activeBars[eventID] = nil
		end
	elseif backupBars[eventID] then
		local newState = C_EncounterTimeline.GetEventState(eventID)
		if newState == 0 then -- Enum.EncounterTimelineEventState.Active
			self:SendMessage("BigWigs_ResumeBar", nil, nil, eventID)
		elseif newState == 1 then -- Enum.EncounterTimelineEventState.Paused
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventID)
		else -- Canceled / Finished
			self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
	elseif backupBars[eventID] then
		backupBars[eventID] = nil
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:PreparingToxinCasts(event, unit)
	toxicAtrophyRemaining = toxicAtrophyRemaining - 1
	if toxicAtrophyRemaining == 0 then
		self:UnregisterUnitEvent(event, unit)
	end
	if self:ShouldShowBars() then
		self:Message(1310358, "red", CL.count_amount:format(self:GetRename(1310358), 3 - toxicAtrophyRemaining, 3)) -- Toxic Atrophy
		self:PlaySound(1310358, "alert")
	end
end

do
	local timer
	function mod:VindictiveOnslaughtCasts(event, unit)
		vindictiveOnslaughtRemaining = vindictiveOnslaughtRemaining - 1
		if vindictiveOnslaughtRemaining == 0 then
			self:UnregisterUnitEvent(event, unit)
		end
		if self:ShouldShowBars() then
			if vindictiveOnslaughtRemaining == 1 then -- first
				self:Message(1299130, "orange", CL.count:format(self:GetRename(1299130), burrowingChargeCount)) -- Burrowing Charge
				burrowingChargeCount = burrowingChargeCount + 1
				self:PlaySound(1299130, "alarm")
				timer = self:ScheduleTimer(function()
					if vindictiveOnslaughtRemaining == 1 then -- Venom Jet was skipped
						vindictiveOnslaughtRemaining = 0
						self:UnregisterUnitEvent(event, unit)
					end
				end, 6)
			else -- vindictiveOnslaughtRemaining == 0, second
				if timer then
					self:CancelTimer(timer)
					timer = nil
				end
				self:Message(1300044, "yellow", CL.count:format(self:GetRename(1300044), venomJetCount)) -- Venom Jet
				venomJetCount = venomJetCount + 1
				self:PlaySound(1300044, "alarm")
			end
		end
	end
end

function mod:SynchronizedVenomTimeline(eventInfo) -- Synchronized Venom
	local barText = CL.count:format(self:GetRename(1299154), synchronizedVenomCount)
	self:CDBar(1299154, eventInfo.duration, barText, nil, eventInfo.id)
	synchronizedVenomCount = synchronizedVenomCount + 1
	return {
		msg = barText,
		key = 1299154,
		callback = function()
			self:Message(1299154, "yellow", barText)
			self:PlaySound(1299154, "alert")
		end
	}
end

function mod:TailScytheTimeline(eventInfo) -- Tail Scythe
	local barText = CL.count:format(self:GetRename(1298949), tailScytheCount)
	self:CDBar(1298949, eventInfo.duration, barText, nil, eventInfo.id)
	tailScytheCount = tailScytheCount + 1
	return {
		msg = barText,
		key = 1298949,
		callback = function()
			self:Message(1298949, "purple", barText)
			self:PlaySound(1298949, "alert")
		end
	}
end

function mod:PreparingToxinTimeline(eventInfo) -- Preparing Toxin
	local barText = CL.count:format(self:GetRename(1310357), preparingToxinCount)
	self:CDBar(1310357, eventInfo.duration, barText, nil, eventInfo.id)
	preparingToxinCount = preparingToxinCount + 1
	return {
		msg = barText,
		key = 1310357,
		callback = function()
			toxicAtrophyRemaining = 3
			self:RegisterUnitEvent("UNIT_SPELLCAST_START", "PreparingToxinCasts", "boss1")
			self:ScheduleTimer(function()
				vindictiveOnslaughtRemaining = 2
				self:RegisterUnitEvent("UNIT_SPELLCAST_START", "VindictiveOnslaughtCasts", "boss1")
			end, 15) -- 15s delay, Vindictive Onslaught starts in 16s and we need to capture its casts
		end
	}
end

function mod:VindictiveOnslaughtTimeline(eventInfo) -- Vindictive Onslaught
	local barText = CL.count:format(self:GetRename(1299940), vindictiveOnslaughtCount)
	self:CDBar(1299940, eventInfo.duration, barText, nil, eventInfo.id)
	vindictiveOnslaughtCount = vindictiveOnslaughtCount + 1
	return {
		msg = barText,
		key = 1299940
	}
end

function mod:DeathRattleTimeline(eventInfo) -- Death Rattle
	if self:GetStage() == 2 then
		self:SetStage(1)
		vindictiveOnslaughtRemaining = 2
		self:RegisterUnitEvent("UNIT_SPELLCAST_START", "VindictiveOnslaughtCasts", "boss1")
	end
	local barText = CL.count:format(self:GetRename(1299053), deathRattleCount)
	self:CDBar(1299053, eventInfo.duration, barText, nil, eventInfo.id)
	deathRattleCount = deathRattleCount + 1
	return {
		msg = barText,
		key = 1299053,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1299053, "yellow", barText)
			self:PlaySound(1299053, "warning")
		end
	}
end

function mod:ToxicAtrophyTimeline(eventInfo) -- Toxic Atrophy
	local barText = CL.count:format(self:GetRename(1310547), toxicAtrophyCount)
	self:CDBar(1310547, eventInfo.duration, barText, nil, eventInfo.id)
	toxicAtrophyCount = toxicAtrophyCount + 1
	return {
		msg = barText,
		key = 1310547,
		callback = function()
			self:Message(1310547, "red", barText)
			self:PlaySound(1310547, "alert")
		end
	}
end

function mod:AssimilationTimeline(eventInfo) -- Assimilation
	self:SetStage(2)
	local barText = CL.count:format(self:GetRename(1300686), assimilationCount)
	self:CDBar(1300686, eventInfo.duration, barText, nil, eventInfo.id)
	assimilationCount = assimilationCount + 1
	return {
		msg = barText,
		key = 1300686,
		callback = function()
			self:Message(1300686, "cyan", barText)
			self:PlaySound(1300686, "info")
		end
	}
end
