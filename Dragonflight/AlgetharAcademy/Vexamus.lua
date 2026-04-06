--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vexamus", 2526, 2509)
if not mod then return end
mod:RegisterEnableMob(194181) -- Vexamus
mod:SetEncounterID(2562)
mod:SetRespawnTime(30)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{386201, sound = "underyou"}, -- Corrupted Mana
		{391977, sound = "alert"}, -- Oversurge
	})
end

--------------------------------------------------------------------------------
-- Locals
--

local arcaneFissureTime = 0
local arcaneOrbsCount = 1
local arcaneFissureCount = 1
local manaBombsCount = 1
local arcaneExpulsionCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Professor Maxdormu
		386544, -- Arcane Orbs
		{391977, "DISPEL"}, -- Oversurge (Mythic only)
		-- Vexamus
		388537, -- Arcane Fissure
		{386173, "SAY", "SAY_COUNTDOWN"}, -- Mana Bombs
		385958, -- Arcane Expulsion
	}, {
		["warmup"] = CL.general,
		[386544] = -25622, -- Professor Maxdormu
		[388537] = -25623, -- Vexamus
	}
end

function mod:OnBossEnable()
	-- Professor Maxdormu
	self:Log("SPELL_CAST_SUCCESS", "ArcaneOrbs", 386544)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OversurgeApplied", 391977)

	-- Vexamus
	self:Log("SPELL_CAST_START", "ArcaneFissure", 388537)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneFissureSuccess", 388537)
	self:Log("SPELL_ENERGIZE", "ArcaneOrbAbsorbed", 386088)
	self:Log("SPELL_CAST_START", "ManaBombs", 386173)
	self:Log("SPELL_AURA_APPLIED", "ManaBombApplied", 386181)
	self:Log("SPELL_AURA_REMOVED", "ManaBombRemoved", 386181)
	self:Log("SPELL_CAST_START", "ArcaneExpulsion", 385958)
end

function mod:OnEngage()
	arcaneFissureCount = 1
	-- 40 second energy gain + ~.9 seconds until energy gain is initially turned on
	arcaneFissureTime = GetTime() + 40.9
	self:CDBar(386544, 4.1) -- Arcane Orbs
	self:CDBar(385958, 12.1) -- Arcane Expulsion
	self:CDBar(386173, 22.1) -- Mana Bombs
	self:CDBar(388537, 40.9, CL.count:format(self:SpellName(388537), 1)) -- Arcane Fissure (1)
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local count18 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			"warmup",
			386544, -- Arcane Orbs
			388537, -- Arcane Fissure
			386173, -- Mana Bombs
			385958, -- Arcane Expulsion
			{386201, "PRIVATE"}, -- Corrupted Mana
			{391977, "PRIVATE"}, -- Oversurge
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		arcaneOrbsCount = 1
		arcaneExpulsionCount = 1
		manaBombsCount = 1
		arcaneFissureCount = 1
		count18 = 1
		activeBars = {}
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		end
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 2 or (duration == 18 and count18 % 3 == 1) then -- Arcane Orbs
		barInfo = self:ArcaneOrbsTimeline(eventInfo)
	elseif duration == 5 or (duration == 18 and count18 % 3 == 2) then -- Arcane Expulsion
		barInfo = self:ArcaneExpulsionTimeline(eventInfo)
	elseif duration == 15 or (duration == 18 and count18 % 3 == 0) then -- Mana Bombs
		barInfo = self:ManaBombsTimeline(eventInfo)
	elseif duration == 40 then -- Arcane Fissure
		barInfo = self:ArcaneFissureTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 18 then
		count18 = count18 + 1
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
			self:PauseBar(barInfo.key,barInfo.msg)
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
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_REMOVED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		self:StopBar(barInfo.msg)
		activeBars[eventID] = nil
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ArcaneOrbsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(386544), arcaneOrbsCount)
	self:CDBar(386544, eventInfo.duration, barText, nil, eventInfo.id)
	arcaneOrbsCount = arcaneOrbsCount + 1
	return {
		msg = barText,
		key = 386544,
		callback = function()
			self:Message(386544, "yellow", barText)
			self:PlaySound(386544, "long")
		end
	}
end

function mod:ArcaneExpulsionTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(385958), arcaneExpulsionCount)
	self:CDBar(385958, eventInfo.duration, barText, nil, eventInfo.id)
	arcaneExpulsionCount = arcaneExpulsionCount + 1
	return {
		msg = barText,
		key = 385958,
		callback = function()
			self:Message(385958, "purple", barText)
			self:PlaySound(385958, "alarm")
		end
	}
end

function mod:ManaBombsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(386173), manaBombsCount)
	self:CDBar(386173, eventInfo.duration, barText, nil, eventInfo.id)
	manaBombsCount = manaBombsCount + 1
	return {
		msg = barText,
		key = 386173,
		callback = function()
			self:Message(386173, "yellow", barText)
			self:PlaySound(386173, "alarm")
		end
	}
end

function mod:ArcaneFissureTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(388537), arcaneFissureCount)
	self:CDBar(388537, eventInfo.duration, barText, nil, eventInfo.id)
	arcaneFissureCount = arcaneFissureCount + 1
	return {
		msg = barText,
		key = 388537,
		callback = function()
			self:Message(388537, "red", barText)
			self:PlaySound(388537, "alert")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 19.7, CL.active, "achievement_dungeon_dragonacademy")
end

-- Professor Maxdormu

function mod:ArcaneOrbs(args)
	self:Message(args.spellId, "yellow")
	-- minimum CD is 20.7, but for each Arcane Fissure cast 3.6 seconds is added
	self:CDBar(args.spellId, 20.7)
	self:PlaySound(args.spellId, "long")
end

function mod:OversurgeApplied(args)
	if args.amount % 2 == 0 and (self:Me(args.destGUID) or self:Dispeller("magic", false, args.spellId)) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 4)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Vexamus

function mod:ArcaneFissure(args)
	self:StopBar(CL.count:format(args.spellName, arcaneFissureCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, arcaneFissureCount))
	arcaneFissureCount = arcaneFissureCount + 1
	-- Arcane Fissure adds 3.6 seconds to all other timers
	local arcaneExpulsionTimeLeft = self:BarTimeLeft(385958)
	if arcaneExpulsionTimeLeft > .1 then
		self:CDBar(385958, {arcaneExpulsionTimeLeft + 3.6, 23.1})
	end
	local manaBombsTimeLeft = self:BarTimeLeft(386173)
	if manaBombsTimeLeft > .1 then
		self:CDBar(386173, {manaBombsTimeLeft + 3.6, 23.1})
	end
	local arcaneOrbsTimeLeft = self:BarTimeLeft(386544)
	if arcaneOrbsTimeLeft > .1 then
		self:CDBar(386544, {arcaneOrbsTimeLeft + 3.6, 20.7})
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:ArcaneFissureSuccess(args)
	-- cast at 100 energy, gains 2.5 energy per second
	self:CDBar(args.spellId, 40.7, CL.count:format(self:SpellName(388537), arcaneFissureCount))
	arcaneFissureTime = GetTime() + 40.7
end

function mod:ArcaneOrbAbsorbed(args)
	-- Vexamus gains 20 energy (8s worth) when it absorbs an orb
	arcaneFissureTime = arcaneFissureTime - 8
	local timeLeft = arcaneFissureTime - GetTime()
	if timeLeft > 0 then
		self:CDBar(388537, {timeLeft, 40.7}, CL.count:format(self:SpellName(388537), arcaneFissureCount)) -- Arcane Fissure
	else
		self:StopBar(CL.count:format(self:SpellName(388537), arcaneFissureCount)) -- Arcane Fissure
	end
end

do
	local playerList = {}

	function mod:ManaBombs(args)
		playerList = {}
		-- minimum CD is 23.1, but for each Arcane Fissure cast 3.6 seconds is added
		self:CDBar(args.spellId, 23.1)
	end

	function mod:ManaBombApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(386173, "yellow", playerList, 3)
		if self:Me(args.destGUID) then
			self:Say(386173, args.spellName, nil, "Mana Bomb")
			self:SayCountdown(386173, 4)
		end
		self:PlaySound(386173, "alarm", nil, playerList)
	end

	function mod:ManaBombRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(386173)
		end
	end
end

function mod:ArcaneExpulsion(args)
	self:Message(args.spellId, "purple")
	-- minimum CD is 23.1, but for each Arcane Fissure cast 3.6 seconds is added
	self:CDBar(args.spellId, 23.1)
	self:PlaySound(args.spellId, "alarm")
end
