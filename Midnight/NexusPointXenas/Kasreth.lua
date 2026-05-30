--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chief Corewright Kasreth", 2915, 2813)
if not mod then return end
mod:SetEncounterID(3328)
mod:SetRespawnTime(30)
mod:SetStage(1)
mod:SetPrivateAuraSounds({
	{1251626, sound = "info", note = CL.debuffWalkIntoObjectNote:format(CL.extra:format(mod:SpellName(1251626), CL.beam))}, -- Leyline Array
	{1251772, sound = "warning"}, -- Reflux Charge
	{1264042, sound = "underyou", note = CL.debuffUnderYouNote}, -- Arcane Spill
	{1276485, sound = "alert", note = CL.debuffDotAfterCastNote:format(CL.extra:format(mod:SpellName(1257509), CL.full_energy))}, -- Sparkburn
})

--------------------------------------------------------------------------------
-- Locals
--

local leylineArrayCount = 1
local refluxChargeCount = 1
local fluxCollapseCount = 1
local coresparkDetonationCount = 1
local leylineArrayRemaining = 4
local refluxChargeRemaining = 3
local fluxCollapseRemaining = 2
local activeBars = {}
local expiringBars = {}
local resumeBars = {}
local resuming = 0
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1251579] = {CL.beams}, -- Leyline Array (Beams)
	[1251772] = {1251772, CL.you:format(mod:SpellName(1251772)), notes = {CL.generalNote, CL.messageOnYouNote}, original = false}, -- Reflux Charge
	[1264048] = {CL.dodge}, -- Flux Collapse (Dodge)
	[1257509] = {CL.full_energy, CL.cast:format(CL.explosion), notes = {CL.generalNote, CL.castTimerNote}, original = {1257509, CL.cast:format(mod:SpellName(1257509))}}, -- Corespark Detonation (Full Energy)
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1251579, -- Leyline Array
		{1251772, "ME_ONLY_EMPHASIZE"}, -- Reflux Charge
		1264048, -- Flux Collapse
		{1257509, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Corespark Detonation
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	leylineArrayCount = 1
	refluxChargeCount = 1
	fluxCollapseCount = 1
	coresparkDetonationCount = 1
	leylineArrayRemaining = 4
	refluxChargeRemaining = 3
	fluxCollapseRemaining = 2
	activeBars = {}
	expiringBars = {}
	resumeBars = {}
	resuming = 0
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	activeBars = {}
	expiringBars = {}
	resumeBars = {}
	resuming = 0
	backupBars = {}
end

function mod:OnBossDisable()
	for eventID in next, backupBars do
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:GetClosestSpell(duration)
	local closestKey = nil
	local minDiff = math.huge
	local threshold = 0.1 -- only match if within 0.1 seconds of expected duration (usually within 0.01)
	for key, remainingTime in pairs(resumeBars) do
		local diff = math.abs(remainingTime - duration)
		if diff < minDiff and diff <= threshold then
			minDiff = diff
			closestKey = key
		end
	end
	if closestKey then
		resumeBars[closestKey] = nil
	end
	return closestKey
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration ~= 38 and resuming > 0 then -- previously canceled timers resume after Corespark Detonation cast
		-- use full precision durations in this block to avoid false positives
		local resumingSpell = self:GetClosestSpell(eventInfo.duration)
		if resumingSpell == 1251579 or (resumingSpell == nil and eventInfo.duration == 11) then -- Leyline Array (Beams)
			resuming = resuming - 1
			barInfo = self:LeylineArrayTimeline(eventInfo)
		elseif resumingSpell == 1251772 or (resumingSpell == nil and eventInfo.duration == 12) then -- Reflux Charge
			resuming = resuming - 1
			barInfo = self:RefluxChargeTimeline(eventInfo)
		elseif resumingSpell == 1264048 or (resumingSpell == nil and eventInfo.duration == 13) then -- Flux Collapse (Dodge)
			resuming = resuming - 1
			barInfo = self:FluxCollapseTimeline(eventInfo)
		elseif not self:IsWiping() then
			resuming = resuming - 1
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		end
	else -- usual timers
		if duration == 1 or duration == 11 then -- Leyline Array (Beams)
			barInfo = self:LeylineArrayTimeline(eventInfo)
		elseif duration == 5 or duration == 12 then -- Reflux Charge
			barInfo = self:RefluxChargeTimeline(eventInfo)
		elseif duration == 10 or duration == 13 then -- Flux Collapse (Dodge)
			barInfo = self:FluxCollapseTimeline(eventInfo)
		elseif duration == 38 then -- Corespark Detonation (Full Energy)
			barInfo = self:CoresparkDetonationTimeline(eventInfo)
		elseif not self:IsWiping() then
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
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
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
		end
	elseif backupBars[eventID] then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Enum.EncounterTimelineEventState.Active
			self:SendMessage("BigWigs_ResumeBar", nil, nil, eventID)
		elseif state == 1 then -- Enum.EncounterTimelineEventState.Paused
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

function mod:LeylineArrayTimeline(eventInfo) -- Beams
	expiringBars[1251579] = GetTime() + eventInfo.duration
	if leylineArrayRemaining == 0 then return end
	leylineArrayRemaining = leylineArrayRemaining - 1
	local barText = CL.count:format(self:GetRename(1251579), leylineArrayCount)
	self:CDBar(1251579, eventInfo.duration, barText, nil, eventInfo.id)
	leylineArrayCount = leylineArrayCount + 1
	return {
		msg = barText,
		key = 1251579,
		callback = function()
			self:Message(1251579, "yellow", barText)
			self:PlaySound(1251579, "info")
		end
	}
end

function mod:RefluxChargeTimeline(eventInfo) -- Reflux Charge / Bomb
	expiringBars[1251772] = GetTime() + eventInfo.duration
	if refluxChargeRemaining == 0 then return end
	refluxChargeRemaining = refluxChargeRemaining - 1
	local barText = CL.count:format(self:GetRename(1251772), refluxChargeCount)
	self:CDBar(1251772, eventInfo.duration, barText, nil, eventInfo.id)
	refluxChargeCount = refluxChargeCount + 1
	return {
		msg = barText,
		key = 1251772,
		callback = function()
			self:Message(1251772, "red", barText)
			self:PersonalMessageFromBlizzMessage(1251772, 1, false, self:GetRename(1251772, 2))
			--self:PlaySound(1251772, "warning") -- PA sound
		end
	}
end

function mod:FluxCollapseTimeline(eventInfo) -- Dodge
	expiringBars[1264048] = GetTime() + eventInfo.duration
	if fluxCollapseRemaining == 0 then return end
	fluxCollapseRemaining = fluxCollapseRemaining - 1
	local barText = CL.count:format(self:GetRename(1264048), fluxCollapseCount)
	self:CDBar(1264048, eventInfo.duration, barText, nil, eventInfo.id)
	fluxCollapseCount = fluxCollapseCount + 1
	return {
		msg = barText,
		key = 1264048,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1264048, "orange", barText)
			self:PlaySound(1264048, "alarm")
		end
	}
end

function mod:CoresparkDetonationTimeline(eventInfo) -- Full Energy / Explosion
	local barText
	if coresparkDetonationCount % 2 == 1 then
		barText = CL.count:format(self:GetRename(1257509), (coresparkDetonationCount + 1) / 2)
		self:CDBar(1257509, eventInfo.duration, barText, nil, eventInfo.id)
		coresparkDetonationCount = coresparkDetonationCount + 1
		return {
			msg = barText,
			key = 1257509,
			cancelCallback = function()
				self:StopBlizzMessages(1)
				self:SetStage(2)
				self:Message(1257509, "cyan", barText)
				self:PlaySound(1257509, "long")
			end,
			callback = function()
				self:Error("Corespark Detonation now has a callback")
			end
		}
	else
		barText = CL.cast:format(self:GetRename(1257509))
		self:CastBar(1257509, 12.8, 2, nil, eventInfo.id)
		coresparkDetonationCount = coresparkDetonationCount + 1
		-- store remaining durations of other bars to resume later based on remaining duration at this point
		resumeBars = {}
		if expiringBars[1251579] then -- Leyline Array (Beams)
			local durationRemaining = expiringBars[1251579] - GetTime()
			if durationRemaining < 0 then
				durationRemaining = 11
			end
			resumeBars[1251579] = durationRemaining
			expiringBars[1251579] = nil
		end
		if expiringBars[1251772] then -- Reflux Charge
			local durationRemaining = expiringBars[1251772] - GetTime()
			if durationRemaining < 0 then
				durationRemaining = 12
			end
			resumeBars[1251772] = durationRemaining
			expiringBars[1251772] = nil
		end
		if expiringBars[1264048] then -- Flux Collapse (Dodge)
			local durationRemaining = expiringBars[1264048] - GetTime()
			if durationRemaining < 0 then
				durationRemaining = 13
			end
			resumeBars[1264048] = durationRemaining
			expiringBars[1264048] = nil
		end
		return {
			msg = barText,
			key = 1257509,
			cancelCallback = function()
				-- 3 previously canceled timers will be resumed
				resuming = 3
				leylineArrayRemaining = 3
				refluxChargeRemaining = 3
				fluxCollapseRemaining = 3
				self:SetStage(1)
				self:StopBlizzMessages(2) -- Flux Collapse will sometimes cast straight after, show a message?
			end
		}
	end
end
