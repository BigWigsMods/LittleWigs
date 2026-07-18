--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kystia Manaheart", 2813, 2679)
if not mod then return end
mod:SetEncounterID(3101)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1228198, sound = "alert"}, -- Corroding Spittle
})

--------------------------------------------------------------------------------
-- Locals
--

local felSprayCount = 1
local mirrorImagesCount = 1
local felNovaCount = 1
local activeBars = {}
local activeBarBySpellId = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1253811] = {1253811}, -- Fel Spray
	[1264095] = {1264095}, -- Mirror Images
	[474240] = {474240},   -- Fel Nova
	[1230304] = {1230304}, -- Light Infusion
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1253811, -- Fel Spray
		1264095, -- Mirror Images
		474240, -- Fel Nova
		1230304, -- Light Infusion
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	felSprayCount = 1
	mirrorImagesCount = 1
	felNovaCount = 1
	activeBars = {}
	activeBarBySpellId = {}
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		self:RegisterEvent("ENCOUNTER_WARNING")
		self:SendMessage("BigWigs_BlockBlizzMessages")
	end
end

function mod:OnBossDisable()
	self:SendMessage("BigWigs_AllowBlizzMessages")
	for eventID in next, backupBars do
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:CancelBarForSpell(spellId)
	local priorEventID = activeBarBySpellId[spellId]
	if priorEventID then
		local barInfo = activeBars[priorEventID]
		if barInfo and barInfo.createdAt and (GetTime() - barInfo.createdAt) < 3 then
			self:StopBar(barInfo.msg)
			activeBars[priorEventID] = nil
			activeBarBySpellId[spellId] = nil
			if spellId == 1253811 then -- Fel Spray
				felSprayCount = felSprayCount - 1
			elseif spellId == 1264095 then -- Mirror Images
				mirrorImagesCount = mirrorImagesCount - 1
			elseif spellId == 474240 then -- Fel Nova
				felNovaCount = felNovaCount - 1
			end
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration == 8 or duration == 27.5 then -- Fel Spray
		self:CancelBarForSpell(1253811)
		barInfo = self:FelSprayTimeline(eventInfo)
	elseif duration == 15 or (not self:IsWiping() and duration == 30) then -- Mirror Images
		self:CancelBarForSpell(1264095)
		barInfo = self:MirrorImagesTimeline(eventInfo)
	elseif duration == 12 or duration == 25 then -- Fel Nova
		-- XXX 12.1 is always 12, remove duration == 25 (BigWigsLoader.isNext)
		self:CancelBarForSpell(474240)
		barInfo = self:FelNovaTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if barInfo then
		barInfo.createdAt = GetTime()
		activeBars[eventInfo.id] = barInfo
		activeBarBySpellId[barInfo.key] = eventInfo.id
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
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
		elseif state == 3 then -- Canceled
			self:StopBar(barInfo.msg)
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
			activeBars[eventID] = nil
			if activeBarBySpellId[barInfo.key] == eventID then
				activeBarBySpellId[barInfo.key] = nil
			end
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
		if activeBarBySpellId[barInfo.key] == eventID then
			activeBarBySpellId[barInfo.key] = nil
		end
	elseif backupBars[eventID] then
		backupBars[eventID] = nil
		self:SendMessage("BigWigs_StopBar", nil, nil, eventID)
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:ENCOUNTER_WARNING(_, info)
	if info.severity == 1 then -- Light Infusion
		self:Message(1230304, "green", self:GetRename(1230304))
		self:PlaySound(1230304, "info")
	-- elseif info.severity == 2 then -- 1253811 Fel Spray (handled via timeline)
	-- elseif info.severity == 0 then -- 1248184 Escape (fight end, ignored)
	end
end

function mod:FelSprayTimeline(eventInfo) -- Fel Spray
	local barText = CL.count:format(self:GetRename(1253811), felSprayCount)
	self:CDBar(1253811, eventInfo.duration, barText, nil, eventInfo.id)
	felSprayCount = felSprayCount + 1
	return {
		msg = barText,
		key = 1253811,
		callback = function()
			self:Message(1253811, "red", barText)
			self:PlaySound(1253811, "alarm")
		end,
		cancelCallback = function()
			felSprayCount = felSprayCount - 1
		end
	}
end

function mod:MirrorImagesTimeline(eventInfo) -- Mirror Images
	local barText = CL.count:format(self:GetRename(1264095), mirrorImagesCount)
	self:CDBar(1264095, eventInfo.duration, barText, nil, eventInfo.id)
	mirrorImagesCount = mirrorImagesCount + 1
	return {
		msg = barText,
		key = 1264095,
		callback = function()
			self:Message(1264095, "cyan", barText)
			self:PlaySound(1264095, "info")
		end,
		cancelCallback = function()
			mirrorImagesCount = mirrorImagesCount - 1
		end
	}
end

function mod:FelNovaTimeline(eventInfo) -- Fel Nova
	local barText = CL.count:format(self:GetRename(474240), felNovaCount)
	self:CDBar(474240, eventInfo.duration, barText, nil, eventInfo.id)
	felNovaCount = felNovaCount + 1
	return {
		msg = barText,
		key = 474240,
		callback = function()
			self:Message(474240, "orange", barText)
			self:PlaySound(474240, "alarm")
		end,
		cancelCallback = function()
			felNovaCount = felNovaCount - 1
		end
	}
end
