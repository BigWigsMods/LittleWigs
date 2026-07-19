--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Charonus", 2923, 2793)
if not mod then return end
mod:SetEncounterID(3287)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1227197, sound = "none"}, -- Cosmic Crash
	{1248130, sound = "underyou"}, -- Unstable Singularity
	{1264188, sound = "none"}, -- Event Horizon
})

--------------------------------------------------------------------------------
-- Locals
--

local unstableSingularityCount = 1
local cosmicCrashCount = 1
local graviticOrbsCount = 1
local darkWavesCount = 1
local voidCascadeCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1282770] = {1282770}, -- Unstable Singularity
	[1227264] = {1227264}, -- Cosmic Crash
	[1263982] = {1263982}, -- Gravitic Orbs
	[1311923] = {1311923}, -- Dark Waves
	[1222755] = {1222755}, -- Void Cascade
})

--------------------------------------------------------------------------------
-- Initialization
--

if BigWigsLoader.isNext then
	function mod:GetOptions()
		return {
			1282770, -- Unstable Singularity
			1227264, -- Cosmic Crash
			1263982, -- Gravitic Orbs
			1311923, -- Dark Waves
			1222755, -- Void Cascade
		}, {
			[1222755] = CL.mythic, -- Void Cascade (Mythic)
		}
	end
else -- XXX remove in 12.1
	function mod:GetOptions()
		return {
			1282770, -- Unstable Singularity
			1227264, -- Cosmic Crash
			1263982, -- Gravitic Orbs
			1222755, -- Void Cascade
		}, {
			[1222755] = CL.mythic, -- Void Cascade (Mythic)
		}
	end
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	unstableSingularityCount = 1
	cosmicCrashCount = 1
	graviticOrbsCount = 1
	darkWavesCount = 1
	voidCascadeCount = 1
	activeBars = {}
	backupBars = {}
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
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if self:Mythic() then -- Mythic
		if duration == 5 then -- Unstable Singularity
			barInfo = self:UnstableSingularityTimeline(eventInfo)
		elseif duration == 17 then -- Cosmic Crash
			barInfo = self:CosmicCrashTimeline(eventInfo)
		elseif duration == 28 then -- Gravitic Orbs
			barInfo = self:GraviticOrbsTimeline(eventInfo)
		elseif duration == 34 then -- Dark Waves
			barInfo = self:DarkWavesTimeline(eventInfo)
		elseif duration == 43 then -- Void Cascade
			barInfo = self:VoidCascadeTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
	else -- Normal / Heroic
		-- TODO: re-check timers in 12.1
		if duration == 5 or duration == 40 then -- Unstable Singularity
			barInfo = self:UnstableSingularityTimeline(eventInfo)
		elseif duration == 19 or duration == 44.8 then -- Cosmic Crash
			barInfo = self:CosmicCrashTimeline(eventInfo)
		elseif duration == 36 or duration == 44 then -- Gravitic Orbs
			barInfo = self:GraviticOrbsTimeline(eventInfo)
		--elseif duration = ?? then -- Dark Waves
			--barInfo = self:DarkWavesTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
			local state = C_EncounterTimeline.GetEventState(eventInfo.id)
			if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
				self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
			end
		end
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

function mod:UnstableSingularityTimeline(eventInfo) -- Unstable Singularity
	local barText = CL.count:format(self:GetRename(1282770), unstableSingularityCount)
	self:CDBar(1282770, eventInfo.duration, barText, nil, eventInfo.id)
	unstableSingularityCount = unstableSingularityCount + 1
	return {
		msg = barText,
		key = 1282770,
		callback = function()
			self:Message(1282770, "orange", barText)
			self:PlaySound(1282770, "alert")
		end
	}
end

function mod:CosmicCrashTimeline(eventInfo) -- Cosmic Crash
	local barText = CL.count:format(self:GetRename(1227264), cosmicCrashCount)
	self:CDBar(1227264, eventInfo.duration, barText, nil, eventInfo.id)
	cosmicCrashCount = cosmicCrashCount + 1
	return {
		msg = barText,
		key = 1227264,
		callback = function()
			self:Message(1227264, "red", barText)
			self:PlaySound(1227264, "alarm")
		end
	}
end

function mod:GraviticOrbsTimeline(eventInfo) -- Gravitic Orbs
	local barText = CL.count:format(self:GetRename(1263982), graviticOrbsCount)
	self:CDBar(1263982, eventInfo.duration, barText, nil, eventInfo.id)
	graviticOrbsCount = graviticOrbsCount + 1
	return {
		msg = barText,
		key = 1263982,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1263982, "cyan", barText)
			self:PlaySound(1263982, "info")
		end
	}
end

function mod:DarkWavesTimeline(eventInfo) -- Dark Waves
	local barText = CL.count:format(self:GetRename(1311923), darkWavesCount)
	self:CDBar(1311923, eventInfo.duration, barText, nil, eventInfo.id)
	darkWavesCount = darkWavesCount + 1
	return {
		msg = barText,
		key = 1311923,
		callback = function()
			self:Message(1311923, "purple", barText)
			self:PlaySound(1311923, "alarm")
		end
	}
end

function mod:VoidCascadeTimeline(eventInfo) -- Void Cascade
	local barText = CL.count:format(self:GetRename(1222755), voidCascadeCount)
	self:CDBar(1222755, eventInfo.duration, barText, nil, eventInfo.id)
	voidCascadeCount = voidCascadeCount + 1
	return {
		msg = barText,
		key = 1222755,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1222755, "yellow", barText)
			self:PlaySound(1222755, "warning")
		end
	}
end
