--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrakka and Erkhart Stormvein", 2521, 2503)
if not mod then return end
mod:RegisterEnableMob(
	190484, -- Kyrakka
	190485  -- Erkhart Stormvein
)
mod:SetEncounterID(2623)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.winds = "Winds"
	L.warmup_icon = "achievement_dungeon_lifepools"
end

--------------------------------------------------------------------------------
-- Locals
--

local windsOfChangeCount = 0
local stageTwoFlamespitCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		-- Kyrakka
		{381862, "SAY", "SAY_COUNTDOWN"}, -- Infernocore
		381525, -- Roaring Firebreath
		381602, -- Flamespit
		-- Erkhart Stormvein
		381517, -- Winds of Change
		381516, -- Interrupting Cloudburst
		{381512, "DISPEL"}, -- Stormslam
	}, {
		[381862] = -25365, -- Kyrakka
		[381517] = -25369, -- Erkhart Stormvein
	}, {
		[381517] = L.winds, -- Winds of Change (Winds)
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "EncounterEvent", 181089)
	self:Death("BossDeath", 190484, 190485)

	-- Kyrakka
	self:Log("SPELL_AURA_APPLIED", "InfernocoreApplied", 381862)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfernocoreApplied", 381862)
	self:Log("SPELL_AURA_REMOVED", "InfernocoreRemoved", 381862)
	self:Log("SPELL_CAST_START", "RoaringFirebreath", 381525)
	self:Log("SPELL_CAST_START", "Flamespit", 381602, 381605) -- P1, P2

	-- Erkhart Stormvein
	self:Log("SPELL_CAST_START", "WindsOfChange", 381517)
	self:Log("SPELL_CAST_START", "InterruptingCloudburst", 381516)
	self:Log("SPELL_CAST_START", "Stormslam", 381512)
	self:Log("SPELL_AURA_APPLIED", "StormslamApplied", 381515)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StormslamApplied", 381515)
end

function mod:OnEngage()
	windsOfChangeCount = 0
	stageTwoFlamespitCount = 0
	self:StopBar(CL.active)
	self:SetStage(1)
	self:CDBar(381525, 1.6) -- Roaring Firebreath
	if self:Tank() or self:Dispeller("magic", nil, 381512) then
		self:CDBar(381512, 6.1) -- Stormslam
	end
	self:CDBar(381602, 15.7) -- Flamespit
	if self:Mythic() then
		self:CDBar(381516, 9.7) -- Interrupting Cloudburst
	end
	if not self:Normal() then
		self:CDBar(381517, 17.0, CL.other:format(L.winds, CL.north_west), "misc_arrowlup") -- Winds of Change
	end
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local roaringFirebreathCount = 1
local stormslamCount = 1
local infernoSpitCount = 1
local interruptingCloudburstCount = 1
local count20 = 1
local count21_5 = 1
local count16 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[381525] = {381525}, -- Roaring Firebreath
		[381512] = {381512}, -- Stormslam
		[381517] = {381517}, -- Winds of Change
		[381862] = {381862, CL.you:format(mod:SpellName(381862)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {381862, CL.you:format(mod:SpellName(381862))}}, -- Inferno Spit
		[381516] = {381516, CL.cast:format(mod:SpellName(381516)), notes = {CL.generalNote, CL.castTimerNote}, original = false}, -- Interrupting Cloudburst
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			"warmup",
			"stages",
			381525, -- Roaring Firebreath
			381862, -- Inferno Spit
			381512, -- Stormslam
			381517, -- Winds of Change
			{381516, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Interrupting Cloudburst
		}, {
			[381525] = -25365, -- Kyrakka
			[381512] = -25369, -- Erkhart Stormvein
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		roaringFirebreathCount = 1
		stormslamCount = 1
		windsOfChangeCount = 1
		infernoSpitCount = 1
		interruptingCloudburstCount = 1
		count20 = 1
		count21_5 = 1
		count16 = 1
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
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration == 1 or (duration == 20 and count20 % 2 == 1) or (duration == 16 and count16 % 2 == 1) then -- Roaring Firebreath
		if duration == 16 and self:GetStage() == 1 then
			self:EncounterEvent() -- Stage 2
		end
		barInfo = self:RoaringFirebreathTimeline(eventInfo)
	elseif duration == 5 or (duration == 21.5 and count21_5 % 2 == 1) then -- Stormslam
		barInfo = self:StormslamTimeline(eventInfo)
	elseif duration == 10 or (duration == 21.5 and count21_5 % 2 == 0) then -- Winds of Change
		barInfo = self:WindsOfChangeTimeline(eventInfo)
	elseif duration == 12 or (duration == 20 and count20 % 2 == 0) or duration == 9 or (duration == 16 and count16 % 2 == 0) then -- Inferno Spit
		barInfo = self:InfernoSpitTimeline(eventInfo)
	elseif duration == 21 or duration == 25 then -- Interrupting Cloudburst
		barInfo = self:InterruptingCloudburstTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 20 then
		count20 = count20 + 1
	end
	if duration == 21.5 then
		count21_5 = count21_5 + 1
	end
	if duration == 16 then
		count16 = count16 + 1
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

function mod:RoaringFirebreathTimeline(eventInfo) -- Roaring Firebreath
	local barText = CL.count:format(self:GetRename(381525), roaringFirebreathCount)
	self:CDBar(381525, eventInfo.duration, barText, nil, eventInfo.id)
	roaringFirebreathCount = roaringFirebreathCount + 1
	return {
		msg = barText,
		key = 381525,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(381525, "orange", barText)
			self:PlaySound(381525, "alarm")
		end
	}
end

function mod:StormslamTimeline(eventInfo) -- Stormslam
	local barText = CL.count:format(self:GetRename(381512), stormslamCount)
	self:CDBar(381512, eventInfo.duration, barText, nil, eventInfo.id)
	stormslamCount = stormslamCount + 1
	return {
		msg = barText,
		key = 381512,
		callback = function()
			self:Message(381512, "purple", barText)
			self:PlaySound(381512, "alert")
		end
	}
end

function mod:WindsOfChangeTimeline(eventInfo) -- Winds of Change
	local barText = CL.count:format(self:GetRename(381517), windsOfChangeCount)
	self:CDBar(381517, eventInfo.duration, barText, nil, eventInfo.id)
	windsOfChangeCount = windsOfChangeCount + 1
	return {
		msg = barText,
		key = 381517,
		callback = function()
			self:Message(381517, "yellow", barText)
			self:PlaySound(381517, "alert")
		end
	}
end

function mod:InfernoSpitTimeline(eventInfo) -- Inferno Spit
	local barText = CL.count:format(self:GetRename(381862), infernoSpitCount)
	self:CDBar(381862, eventInfo.duration, barText, nil, eventInfo.id)
	infernoSpitCount = infernoSpitCount + 1
	return {
		msg = barText,
		key = 381862,
		callback = function()
			self:PersonalMessageFromBlizzMessage(381862, 1, false, self:GetRename(381862, 2)) -- TODO confirm
			self:Message(381862, "orange", barText)
			self:PlaySound(381862, "alarm")
		end
	}
end

function mod:InterruptingCloudburstTimeline(eventInfo) -- Interrupting Cloudburst
	local barText = CL.count:format(self:GetRename(381516), interruptingCloudburstCount)
	self:CDBar(381516, eventInfo.duration, barText, nil, eventInfo.id)
	interruptingCloudburstCount = interruptingCloudburstCount + 1
	return {
		msg = barText,
		key = 381516,
		callback = function()
			self:Message(381516, "red", barText)
			self:CastBar(381516, 5, 2)
			self:PlaySound(381516, "warning")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 10.7, CL.active, L.warmup_icon)
end

-- Stages

function mod:UNIT_HEALTH(event, unit)
	-- stage 2 trigger is either boss hitting 50%, but it takes some time for the bosses to get in position
	if self:GetHealth(unit) <= 50 then
		self:UnregisterUnitEvent(event, "boss1")
		self:UnregisterUnitEvent(event, "boss2")
		self:Message("stages", "cyan", CL.percent:format(50, CL.soon:format(CL.stage:format(2))), false)
		self:PlaySound("stages", "info")
	end
end

function mod:EncounterEvent()
	-- when either boss reaches 50%, Kyrakka lands so Erkhart can remount
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

function mod:BossDeath(args)
	if self:GetStage() ~= 3 then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		if args.mobId == 190484 then -- Kyrakka
			self:StopBar(381525) -- Roaring Firebreath
			self:StopBar(381602) -- Flamespit
		else -- Erkhart Stormvein
			local nextDirection
			if windsOfChangeCount % 4 == 1 then
				nextDirection = CL.south_west
			elseif windsOfChangeCount % 4 == 2 then
				nextDirection = CL.south_east
			elseif windsOfChangeCount % 4 == 3 then
				nextDirection = CL.north_east
			elseif windsOfChangeCount % 4 == 0 then
				nextDirection = CL.north_west
			end
			self:StopBar(CL.other:format(L.winds, nextDirection)) -- Winds of Change
			self:StopBar(381516) -- Interrupting Cloudburst
			self:StopBar(381512) -- Stormslam
		end
		self:PlaySound("stages", "long")
	end
end

-- Kyrakka

do
	local prev = 0
	local onMe = nil

	function mod:InfernocoreApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				if args.amount then
					self:StackMessage(args.spellId, "blue", args.destName, args.amount, 2)
				else
					self:PersonalMessage(args.spellId)
				end
				self:PlaySound(args.spellId, "alarm")
			end
			if not onMe then
				onMe = true
				self:Say(args.spellId, nil, nil, "Infernocore")
			else
				self:CancelSayCountdown(args.spellId)
			end
			self:SayCountdown(args.spellId, 4, nil, 2)
			self:TargetBar(args.spellId, 4, args.destName)
		end
	end

	function mod:InfernocoreRemoved(args)
		if self:Me(args.destGUID) then
			onMe = nil
			self:StopBar(args.spellId, args.destName)
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:RoaringFirebreath(args)
	self:Message(args.spellId, "orange")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 19.1)
	else
		self:CDBar(args.spellId, 18.2)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:Flamespit(args)
	self:Message(381602, "red")
	if args.spellId == 381602 then -- stage 1 Flamespit
		self:CDBar(381602, 19.5)
	else -- 381605, stage 2/3 Flamespit
		stageTwoFlamespitCount = stageTwoFlamespitCount + 1
		if stageTwoFlamespitCount == 1 then
			self:CDBar(381602, 15.8)
		else
			self:CDBar(381602, 18.2)
		end
	end
	self:PlaySound(381602, "alert")
end

-- Erkhart Stormvein

function mod:WindsOfChange(args)
	windsOfChangeCount = windsOfChangeCount + 1
	local direction, nextDirection, icon, nextIcon
	if windsOfChangeCount % 4 == 1 then
		direction = CL.north_west
		nextDirection = CL.south_west
		icon = "misc_arrowlup"
		nextIcon = "misc_arrowleft"
	elseif windsOfChangeCount % 4 == 2 then
		direction = CL.south_west
		nextDirection = CL.south_east
		icon = "misc_arrowleft"
		nextIcon = "misc_arrowdown"
	elseif windsOfChangeCount % 4 == 3 then
		direction = CL.south_east
		nextDirection = CL.north_east
		icon = "misc_arrowdown"
		nextIcon = "misc_arrowright"
	elseif windsOfChangeCount % 4 == 0 then
		direction = CL.north_east
		nextDirection = CL.north_west
		icon = "misc_arrowright"
		nextIcon = "misc_arrowlup"
	end
	self:Message(args.spellId, "yellow", CL.other:format(L.winds, direction), icon)
	self:StopBar(CL.other:format(L.winds, direction))
	self:CDBar(args.spellId, 19.4, CL.other:format(L.winds, nextDirection), nextIcon)
	self:PlaySound(args.spellId, "alert")
end

function mod:InterruptingCloudburst(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "warning")
end

function mod:Stormslam(args)
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 17.0)
		self:PlaySound(args.spellId, "alarm")
	elseif self:Dispeller("magic", nil, args.spellId) then
		self:CDBar(args.spellId, 17.0)
	end
end

function mod:StormslamApplied(args)
	if self:Dispeller("magic", nil, 381512) then
		self:StackMessage(381512, "purple", args.destName, args.amount, 2)
		self:PlaySound(381512, "alert")
	end
end
