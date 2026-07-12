--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Merektha", 1877, 2143)
if not mod then return end
mod:RegisterEnableMob(133384, 134487) -- Creature and Vehicle
mod:SetEncounterID(2125)
if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRespawnTime(30)
else
	mod:SetRespawnTime(20)
end
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		263912, -- Noxious Breath
		263927, -- Toxic Pool
		{263914, "CASTBAR"}, -- Blinding Sand
		264239, -- Hatch
		264206, -- Burrow
		{263958, "SAY", "ICON"}, -- A Knot of Snakes
	}, {
		[263912] = "general",
		[263958] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NoxiousBreath", 263912)
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 263927)
	self:Log("SPELL_CAST_START", "BlindingSand", 263914)
	self:Log("SPELL_CAST_START", "Hatch", 264239, 264233) -- different sides
	self:Log("SPELL_AURA_APPLIED", "AKnotOfSnakes", 263958)
	self:Log("SPELL_AURA_REMOVED", "AKnotOfSnakesRemoved", 263958)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(263912, 6) -- Noxious Breath
	self:Bar(263958, 12) -- A Knot of Snakes
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local lightningBiteCount = 1
local aKnotOfSnakesCount = 1
local thunderSpitCount = 1
local serpentstormCount = 1
local hatchCount = 1
local burrowCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[1290797] = {1290797}, -- Lightning Bite
		[1290029] = {1290029}, -- A Knot of Snakes
		[1289109] = {1289109}, -- Thunder Spit
		[1293048] = {1293048}, -- Serpentstorm
		[1289205] = {1289205}, -- Hatch
		[264172] = {264172, CL.cast:format(mod:SpellName(264172)), CL.over:format(mod:SpellName(264172)), notes = {CL.generalNote, CL.messageNote, CL.messageNote}, original = false}, -- Burrow
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			1290797, -- Lightning Bite
			1290029, -- A Knot of Snakes
			1289109, -- Thunder Spit
			1293048, -- Serpentstorm
			1289205, -- Hatch
			264172, -- Burrow
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		lightningBiteCount = 1
		aKnotOfSnakesCount = 1
		thunderSpitCount = 1
		serpentstormCount = 1
		hatchCount = 1
		burrowCount = 1
		activeBars = {}
		backupBars = {}
		self:SetStage(1)
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
			self:SendMessage("BigWigs_BlockBlizzMessages")
			self:RegisterEvent("ENCOUNTER_WARNING")
			self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
		end
	end

	function mod:OnBossDisable()
		self:SendMessage("BigWigs_AllowBlizzMessages")
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 5 then -- Lightning Bite
		barInfo = self:LightningBiteTimeline(eventInfo)
	elseif duration == 13 then -- A Knot of Snakes
		barInfo = self:AKnotOfSnakesTimeline(eventInfo)
	elseif duration == 25 then -- Thunder Spit
		barInfo = self:ThunderSpitTimeline(eventInfo)
	elseif duration == 36 then -- Serpentstorm
		barInfo = self:SerpentstormTimeline(eventInfo)
	elseif duration == 44 then -- Hatch
		barInfo = self:HatchTimeline(eventInfo)
	elseif duration == 49 then -- Burrow
		barInfo = self:BurrowTimeline(eventInfo)
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

do
	local prev = 0
	function mod:ENCOUNTER_WARNING(_, info)
		if info.targetGUID == nil then return end -- filter Burrow
		self:SecretTargetMessage(1290029, "red", info) -- A Knot of Snakes
		local t = GetTime()
		if t - prev > 2 then
			prev = t
			self:PlaySound(1290029, "warning") -- A Knot of Snakes
		end
	end
end

function mod:LightningBiteTimeline(eventInfo) -- Lightning Bite
	local barText = CL.count:format(self:GetRename(1290797), lightningBiteCount)
	self:CDBar(1290797, eventInfo.duration, barText, nil, eventInfo.id)
	lightningBiteCount = lightningBiteCount + 1
	return {
		msg = barText,
		key = 1290797,
		callback = function()
			self:Message(1290797, "yellow", barText)
			self:PlaySound(1290797, "info")
		end
	}
end

function mod:AKnotOfSnakesTimeline(eventInfo) -- A Knot of Snakes
	local barText = CL.count:format(self:GetRename(1290029), aKnotOfSnakesCount)
	self:CDBar(1290029, eventInfo.duration, barText, nil, eventInfo.id)
	aKnotOfSnakesCount = aKnotOfSnakesCount + 1
	return {
		msg = barText,
		key = 1290029,
		callback = function()
			self:Message(1290029, "red", barText)
			self:PlaySound(1290029, "warning")
		end
	}
end

function mod:ThunderSpitTimeline(eventInfo) -- Thunder Spit
	local barText = CL.count:format(self:GetRename(1289109), thunderSpitCount)
	self:CDBar(1289109, eventInfo.duration, barText, nil, eventInfo.id)
	thunderSpitCount = thunderSpitCount + 1
	return {
		msg = barText,
		key = 1289109,
		callback = function()
			self:Message(1289109, "yellow", barText)
			self:PlaySound(1289109, "info")
		end
	}
end

function mod:SerpentstormTimeline(eventInfo) -- Serpentstorm
	local barText = CL.count:format(self:GetRename(1293048), serpentstormCount)
	self:CDBar(1293048, eventInfo.duration, barText, nil, eventInfo.id)
	serpentstormCount = serpentstormCount + 1
	return {
		msg = barText,
		key = 1293048,
		callback = function()
			self:Message(1293048, "yellow", barText)
			self:PlaySound(1293048, "info")
		end
	}
end

function mod:HatchTimeline(eventInfo) -- Hatch
	local barText = CL.count:format(self:GetRename(1289205), hatchCount)
	self:CDBar(1289205, eventInfo.duration, barText, nil, eventInfo.id)
	hatchCount = hatchCount + 1
	return {
		msg = barText,
		key = 1289205,
		callback = function()
			self:Message(1289205, "yellow", barText)
			self:PlaySound(1289205, "info")
		end
	}
end

function mod:BurrowTimeline(eventInfo) -- Burrow
	local barText = CL.count:format(self:GetRename(264172), burrowCount)
	self:CDBar(264172, eventInfo.duration, barText, nil, eventInfo.id)
	burrowCount = burrowCount + 1
	return {
		msg = barText,
		key = 264172,
		callback = function()
			self:Message(264172, "cyan", barText)
			self:PlaySound(264172, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED(_, unit) -- Burrow
	if UnitCanAttack("player", unit) then
		self:SetStage(1)
		if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
			self:StopBar(self:GetRename(264172, 2)) -- <Cast: Burrow>
			self:Message(264172, "green", self:GetRename(264172, 3)) -- Burrow over
			self:PlaySound(264172, "info") -- Burrow
		elseif not self:Retail() then
			self:StopBar(264206) -- Burrow
			self:Message(264206, "green", CL.over:format(self:SpellName(264206))) -- Burrow
			self:CDBar(263914, 6) -- Blinding Sand
			self:CDBar(263958, 8) -- A Knot of Snakes
			self:PlaySound(264206, "info") -- Burrow
		end
	else
		self:SetStage(2)
		if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
			self:Bar(264172, 21, self:GetRename(264172, 2)) -- <Cast: Burrow>
		elseif not self:Retail() then
			self:Message(264206, "cyan") -- Burrow
			self:Bar(264206, 29) -- Burrow
			self:StopBar(264239) -- Hatch
			self:StopBar(263912) -- Noxious Breath
			self:PlaySound(264206, "long") -- Burrow
		end
	end
end

function mod:NoxiousBreath(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 9)
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:BlindingSand(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 2.5)
end

do
	local prev = 0
	function mod:Hatch(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Bar(264239, 35)
		end
	end
end

function mod:AKnotOfSnakes(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "A Knot of Snakes")
	end
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
	self:TargetBar(args.spellId, 15, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:AKnotOfSnakesRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
