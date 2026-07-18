--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lightwarden Ruia", 2859, 2771)
if not mod then return end
mod:SetEncounterID(3201)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1239825, sound = "none"}, -- Lightfire
	{1239919, sound = "underyou"}, -- Lightfire Beams
	{1241058, sound = "none"}, -- Grievous Thrash
	{1251345, sound = "underyou"}, -- Blight Resin
	{1257094, sound = "none"}, -- Pulverized
})
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local lightfireCount = 1
local lightfallCount = 1
local grievousThrashCount = 1
local pulverizingStrikesCount = 1
local sharedCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1239882] = {1239882}, -- Shapeshift: Moonkin
	[1239824] = {1239824, CL.you:format(mod:SpellName(1239824)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1239824, CL.you:format(mod:SpellName(1239824))}}, -- Lightfire
	[1240098] = {1240098}, -- Lightfall
	[1239885] = {1239885}, -- Shapeshift: Bear
	[1241058] = {1241058}, -- Grievous Thrash
	[1240210] = {1240210, CL.incoming:format(mod:SpellName(1240210)), original = {1240210, CL.incoming:format(mod:SpellName(1240210))}}, -- Pulverizing Strikes
	[1239883] = {1239883}, -- Shapeshift: Haranir
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1239882, -- Shapeshift: Moonkin
		1239824, -- Lightfire
		1240098, -- Lightfall
		1239885, -- Shapeshift: Bear
		1241058, -- Grievous Thrash
		1240210, -- Pulverizing Strikes
		1239883, -- Shapeshift: Haranir
	}, {
		[1239882] = -33012, -- Moonkin Form
		[1239885] = -33015, -- Bear Form
		[1239883] = -33016, -- Haranir Form
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	lightfireCount = 1
	lightfallCount = 1
	grievousThrashCount = 1
	pulverizingStrikesCount = 1
	sharedCount = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration == 0.5 then -- Shapeshift: Moonkin
		barInfo = self:ShapeshiftMoonkinTimeline(eventInfo)
	elseif duration == 2.5 then -- Spirits of the Vale
		self:SpiritsOfTheValeTimeline(eventInfo)
	elseif self:GetStage() == 3 then
		-- TODO in Stage 3 these timers will all be canceled with 0.5s left.
		-- we should probably just schedule their callbacks to fire then unless Blizzard fixes these.
		if duration == 7.3 or (duration == 32 and sharedCount % 4 == 1) then
			barInfo = self:LightfireTimeline(eventInfo)
		elseif duration == 15.3 or (duration == 32 and sharedCount % 4 == 2) then
			barInfo = self:GrievousThrashTimeline(eventInfo)
		elseif duration == 23.3 or (duration == 32 and sharedCount % 4 == 3) then
			barInfo = self:LightfallTimeline(eventInfo)
		elseif duration == 31.3 or (duration == 32 and sharedCount % 4 == 0) then
			barInfo = self:PulverizingStrikesTimeline(eventInfo)
		end
	elseif duration == 5 or (self:GetStage() == 1 and duration >= 20 and duration <= 21 and sharedCount % 2 == 1) then
		barInfo = self:LightfireTimeline(eventInfo)
	elseif duration == 18 or (self:GetStage() == 1 and duration >= 20 and duration <= 21 and sharedCount % 2 == 0) then
		barInfo = self:LightfallTimeline(eventInfo)
	elseif duration == 3 or (self:GetStage() == 2 and duration >= 20 and duration <= 21 and sharedCount % 2 == 1) then
		barInfo = self:GrievousThrashTimeline(eventInfo)
	elseif duration == 9 or (self:GetStage() == 2 and duration >= 20 and duration <= 21 and sharedCount % 2 == 0) then
		barInfo = self:PulverizingStrikesTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if (duration >= 20 and duration <= 21) or duration == 32 then
		sharedCount = sharedCount + 1
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

function mod:ShapeshiftMoonkinTimeline(eventInfo) -- Shapeshift: Moonkin
	local barText = self:GetRename(1239882)
	self:CDBar(1239882, eventInfo.duration, barText, nil, eventInfo.id)
	return {
		msg = barText,
		key = 1239882,
		callback = function()
			self:Message(1239882, "cyan", barText)
			self:PlaySound(1239882, "info")
		end
	}
end

function mod:LightfireTimeline(eventInfo) -- Lightfire
	local barText = CL.count:format(self:GetRename(1239824), lightfireCount)
	self:CDBar(1239824, eventInfo.duration, barText, nil, eventInfo.id)
	lightfireCount = lightfireCount + 1
	return {
		msg = barText,
		key = 1239824,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1239824, 3, false, self:GetRename(1239824, 2))
			self:Message(1239824, "yellow", barText)
			self:PlaySound(1239824, "alarm")
		end
	}
end

function mod:LightfallTimeline(eventInfo) -- Lightfall
	local barText = CL.count:format(self:GetRename(1240098), lightfallCount)
	self:CDBar(1240098, eventInfo.duration, barText, nil, eventInfo.id)
	lightfallCount = lightfallCount + 1
	return {
		msg = barText,
		key = 1240098,
		callback = function()
			self:Message(1240098, "orange", barText)
			self:PlaySound(1240098, "alarm")
		end
	}
end

function mod:GrievousThrashTimeline(eventInfo) -- Grievous Thrash
	if self:GetStage() == 1 then
		self:SetStage(2)
		sharedCount = 1
		self:Message(1239885, "cyan", self:GetRename(1239885)) -- Shapeshift: Bear
		self:PlaySound(1239885, "info")
	end
	local barText = CL.count:format(self:GetRename(1241058), grievousThrashCount)
	self:CDBar(1241058, eventInfo.duration, barText, nil, eventInfo.id)
	grievousThrashCount = grievousThrashCount + 1
	return {
		msg = barText,
		key = 1241058,
		callback = function()
			self:Message(1241058, "red", barText)
			self:PlaySound(1241058, "alert")
		end
	}
end

do
	local pulverizingStrikesRemaining = 0

	function mod:UNIT_SPELLCAST_START(event, unit)
		pulverizingStrikesRemaining = pulverizingStrikesRemaining - 1
		if pulverizingStrikesRemaining == 0 then
			self:UnregisterUnitEvent(event, unit)
		end
		if self:ShouldShowBars() then
			self:Message(1240210, "orange", CL.count_amount:format(self:GetRename(1240210), 3 - pulverizingStrikesRemaining, 3))
			self:PlaySound(1240210, "alarm")
		end
	end

	function mod:PulverizingStrikesTimeline(eventInfo) -- Pulverizing Strikes
		local barText = CL.count:format(self:GetRename(1240210), pulverizingStrikesCount)
		self:CDBar(1240210, eventInfo.duration, barText, nil, eventInfo.id)
		pulverizingStrikesCount = pulverizingStrikesCount + 1
		return {
			msg = barText,
			key = 1240210,
			callback = function()
				if BigWigsLoader.isNext then
					if self:GetStage() ~= 3 then -- Stage 2
						pulverizingStrikesRemaining = 2
					else -- Stage 3
						pulverizingStrikesRemaining = 3
					end
				else -- XXX remove in 12.1
					pulverizingStrikesRemaining = 3
				end
				self:SimpleTimer(function()
					self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss1")
				end, 0.1)
				self:Message(1240210, "yellow", self:GetRename(1240210, 2)) -- Pulverizing Strikes incoming
			end
		}
	end
end

function mod:SpiritsOfTheValeTimeline()
	self:SetStage(3)
	lightfireCount = lightfireCount - 1
	lightfallCount = lightfallCount - 1
	grievousThrashCount = grievousThrashCount - 1
	pulverizingStrikesCount = pulverizingStrikesCount - 1
	sharedCount = 1
	self:Message(1239883, "cyan", self:GetRename(1239883)) -- Shapeshift: Haranir
	self:PlaySound(1239883, "info")
end
