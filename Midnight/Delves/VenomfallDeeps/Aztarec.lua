--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azta'rec", 3079)
if not mod then return end
mod:SetEncounterID({3508, 3525}) -- Tier 8, Tier 11
mod:SetAllowWin(true)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:SetDefaultLocale({
	aztarec = "Azta'rec",
})
mod.displayName = L.aztarec

--------------------------------------------------------------------------------
-- Locals
--

local noxiousBileCount = 1
local voidToxinCount = 1
local serpentsStrikeCount = 1
local soulExtinctionCount = 1
local venomStormCount = 1
local sermonOfUlatekCount = 1
local echoOfUlatekCount = 1
local activeBars = {}
local backupBars = {}
local hardMode = true

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1291555] = {1291555}, -- Noxious Bile
	[1293824] = {1293824}, -- Void Toxin
	[1293825] = {1293825}, -- Serpent's Strike
	[1294963] = {1294963}, -- Soul Extinction
	[1309418] = {1309418}, -- Venom Storm
	[1288103] = {1288103}, -- Sermon of Ula'tek
	[1288125] = {1288125}, -- Echo of Ula'tek
})

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1291555, duration = 21, note = CL.debuffHitByCastNote:format(mod:SpellName(1291555))}, -- Noxious Bile
	{1293824, duration = 18, dispel = "magic", note = CL.debuffDotAfterCastNote:format(mod:SpellName(1293824))}, -- Void Toxin
	{1298887, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Noxious Venom
	{1297422, soundOnApplied = "underyou", note = CL.debuffUnderYouNote}, -- Deadly Venom
	{1313213, soundOnApplied = "warning", note = CL.debuffHitByCastNote:format(mod:SpellName(1288125))}, -- Ula'tek's Mark
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1291555, -- Noxious Bile
		1293824, -- Void Toxin
		1293825, -- Serpent's Strike
		1294963, -- Soul Extinction
		1309418, -- Venom Storm
		1288103, -- Sermon of Ula'tek
		1288125, -- Echo of Ula'tek
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	noxiousBileCount = 1
	voidToxinCount = 1
	serpentsStrikeCount = 1
	soulExtinctionCount = 1
	venomStormCount = 1
	sermonOfUlatekCount = 1
	echoOfUlatekCount = 1
	activeBars = {}
	backupBars = {}
	local info = self:GetWidgetInfo("delve", 6185) -- ?? Difficulty
	hardMode = info ~= nil and info.shownState == 1
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", nil, "boss1")
		self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss1")
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
	local duration = self:RoundNumber(eventInfo.duration, 3)
	local barInfo
	-- DPS/Healer have shorter timers on Soul Extinction and Venom Storm in exchange for no Serpent's Strike
	-- TODO can/should we check initial timers to differentiate between tank vs non-tank sets for the whole fight?
	if duration == 6 or (hardMode and (duration == 20.5 or duration == 20.75)) or duration == 21 or duration == 21.025 then -- Noxious Bile
		barInfo = self:NoxiousBileTimeline(eventInfo)
	elseif duration == 10 or duration == 21.25 or duration == 21.375 or duration == 21.5 or duration == 21.65 or duration == 21.815 then -- Void Toxin
		barInfo = self:VoidToxinTimeline(eventInfo)
	elseif (not self:IsWiping() and duration == 15) or duration == 17.5 then -- Serpent's Strike (tank only)
		barInfo = self:SerpentsStrikeTimeline(eventInfo)
	elseif duration == 18 or duration == 20 or duration == 20.42 or (not hardMode and duration == 20.5) or duration == 34.667 or duration == 35 or duration == 35.2 or duration == 35.42 then -- Soul Extinction
		barInfo = self:SoulExtinctionTimeline(eventInfo)
	elseif duration == 23 or duration == 26 or duration == 28.5 or duration == 28.65 or duration == 28.815 or duration == 31.5 then -- Venom Storm
		barInfo = self:VenomStormTimeline(eventInfo)
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
-- Cast Alert Handler
--

function mod:UNIT_SPELLCAST_CHANNEL_START(_, unit)
	if unit == "boss1" then
		echoOfUlatekCount = 1
		self:SetStage(2)
		if sermonOfUlatekCount == 1 then
			self:Message(1288103, "cyan", CL.percent:format(90, self:GetRename(1288103)))
		elseif sermonOfUlatekCount == 2 then
			self:Message(1288103, "cyan", CL.percent:format(60, self:GetRename(1288103)))
		else -- 3
			self:Message(1288103, "cyan", CL.percent:format(30, self:GetRename(1288103)))
		end
		sermonOfUlatekCount = sermonOfUlatekCount + 1
		self:PlaySound(1288103, "long")
	end
end

function mod:UNIT_SPELLCAST_START(_, unit)
	if unit == "boss1" and self:GetStage() == 2 then
		local threshold
		if sermonOfUlatekCount == 2 then
			threshold = hardMode and 5 or 3
		elseif sermonOfUlatekCount == 3 then
			threshold = hardMode and 6 or 4
		else -- 4
			threshold = hardMode and 7 or 5
		end
		if echoOfUlatekCount <= threshold then
			self:Message(1288125, "cyan", CL.count_amount:format(self:GetRename(1288125), echoOfUlatekCount, threshold))
			if echoOfUlatekCount == threshold then
				self:SetStage(1)
			else
				echoOfUlatekCount = echoOfUlatekCount + 1
			end
			self:PlaySound(1288125, "info")
		end
	end
end

--------------------------------------------------------------------------------
-- Timeline Ability Handlers
--

function mod:NoxiousBileTimeline(eventInfo) -- Noxious Bile
	local barText = CL.count:format(self:GetRename(1291555), noxiousBileCount)
	self:CDBar(1291555, eventInfo.duration, barText, nil, eventInfo.id)
	noxiousBileCount = noxiousBileCount + 1
	return {
		msg = barText,
		key = 1291555,
		callback = function()
			self:Message(1291555, "red", barText)
			self:PlaySound(1291555, "alarm")
		end
	}
end

function mod:VoidToxinTimeline(eventInfo) -- Void Toxin
	local barText = CL.count:format(self:GetRename(1293824), voidToxinCount)
	self:CDBar(1293824, eventInfo.duration, barText, nil, eventInfo.id)
	voidToxinCount = voidToxinCount + 1
	return {
		msg = barText,
		key = 1293824,
		callback = function()
			self:Message(1293824, "yellow", barText)
			self:PlaySound(1293824, "info")
		end
	}
end

function mod:SerpentsStrikeTimeline(eventInfo) -- Serpent's Strike
	local barText = CL.count:format(self:GetRename(1293825), serpentsStrikeCount)
	self:CDBar(1293825, eventInfo.duration, barText, nil, eventInfo.id)
	serpentsStrikeCount = serpentsStrikeCount + 1
	return {
		msg = barText,
		key = 1293825,
		callback = function()
			self:Message(1293825, "purple", barText)
			self:PlaySound(1293825, "alert")
		end
	}
end

function mod:SoulExtinctionTimeline(eventInfo) -- Soul Extinction
	local barText = CL.count:format(self:GetRename(1294963), soulExtinctionCount)
	self:CDBar(1294963, eventInfo.duration, barText, nil, eventInfo.id)
	soulExtinctionCount = soulExtinctionCount + 1
	return {
		msg = barText,
		key = 1294963,
		callback = function()
			self:Message(1294963, "red", barText)
			self:PlaySound(1294963, "warning")
		end
	}
end

function mod:VenomStormTimeline(eventInfo) -- Venom Storm
	local barText = CL.count:format(self:GetRename(1309418), venomStormCount)
	self:CDBar(1309418, eventInfo.duration, barText, nil, eventInfo.id)
	venomStormCount = venomStormCount + 1
	return {
		msg = barText,
		key = 1309418,
		callback = function()
			self:Message(1309418, "orange", barText)
			self:PlaySound(1309418, "info")
		end
	}
end
