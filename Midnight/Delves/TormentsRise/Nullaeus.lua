--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nullaeus", 2966)
if not mod then return end
mod:SetEncounterID({3372, 3430}) -- Tier 8, Tier 11
mod:SetAllowWin(true)
mod:SetRespawnTime(15)
mod:SetPrivateAuraSounds({
	{1256045, sound = "underyou"}, -- Null Zone
	{1256167, sound = "underyou"}, -- Void Hole
	{1256358, sound = "none"}, -- Devouring Essence
	{1256366, sound = "none"}, -- Jagged Rip
	{1256518, sound = "none"}, -- Poisonous Spit
	{1256526, sound = "info"}, -- Curse of Hesitation
})

--------------------------------------------------------------------------------
-- Locals
--

local emptinessOfTheVoidCount = 1
local implodingStrikeCount = 1
local devouringEssenceCount = 1
local addsCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nullaeus = "Nullaeus"
	L.adds_icon = "inv_babyvoidwalker_silver"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nullaeus
end

function mod:GetOptions()
	return {
		1280086, -- Emptiness of the Void
		1280087, -- Imploding Strike
		1280088, -- Devouring Essence
		"adds",
		{1256045, "PRIVATE"}, -- Null Zone
		{1256167, "PRIVATE"}, -- Void Hole
		--{1256358, "PRIVATE"}, -- Devouring Essence
		{1256366, "PRIVATE"}, -- Jagged Rip
		{1256518, "PRIVATE"}, -- Poisonous Spit
		{1256526, "PRIVATE"}, -- Curse of Hesitation
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	emptinessOfTheVoidCount = 1
	implodingStrikeCount = 1
	devouringEssenceCount = 1
	addsCount = 1
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
	if duration == 7 or duration == 21 or duration == 21.3 then -- Emptiness of the Void
		barInfo = self:EmptinessOfTheVoidTimeline(eventInfo)
	elseif duration == 12 or duration == 15.5 or duration == 15.8 then -- Imploding Strike
		-- this is only cast if a tank is the leader
		barInfo = self:ImplodingStrikeTimeline(eventInfo)
	elseif duration == 16 or duration == 18.5 or duration == 18.8 then -- Devouring Essence
		barInfo = self:DevouringEssenceTimeline(eventInfo)
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
			-- bars pausing means adds are spawning (and also just stop the bars)
			self:StopBar(barInfo.msg)
			self:Adds()
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

function mod:EmptinessOfTheVoidTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1280086), emptinessOfTheVoidCount)
	self:CDBar(1280086, eventInfo.duration, barText, nil, eventInfo.id)
	if emptinessOfTheVoidCount > 1 then
		self:Message(1280086, "red", CL.casting:format(CL.count:format(self:SpellName(1280086), emptinessOfTheVoidCount - 1)))
		self:PlaySound(1280086, "warning")
	end
	emptinessOfTheVoidCount = emptinessOfTheVoidCount + 1
	return {
		msg = barText,
		key = 1280086,
	}
end

function mod:ImplodingStrikeTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1280087), implodingStrikeCount)
	self:CDBar(1280087, eventInfo.duration, barText, nil, eventInfo.id)
	if implodingStrikeCount > 1 then
		self:Message(1280087, "orange", CL.count:format(self:SpellName(1280087), implodingStrikeCount - 1))
		self:PlaySound(1280087, "alarm")
	end
	implodingStrikeCount = implodingStrikeCount + 1
	return {
		msg = barText,
		key = 1280087
	}
end

function mod:DevouringEssenceTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1280088), devouringEssenceCount)
	self:CDBar(1280088, eventInfo.duration, barText, nil, eventInfo.id)
	if devouringEssenceCount > 1 then
		self:Message(1280088, "yellow", CL.count:format(self:SpellName(1280088), devouringEssenceCount - 1))
		self:PlaySound(1280088, "info")
	end
	devouringEssenceCount = devouringEssenceCount + 1
	return {
		msg = barText,
		key = 1280088,
	}
end

do
	local prev = 0
	function mod:Adds()
		if GetTime() - prev > 2 then
			prev = GetTime()
			self:Message("adds", "cyan", CL.count_amount:format(CL.adds_spawning, addsCount, 3), L.adds_icon)
			addsCount = addsCount + 1
			self:PlaySound("adds", "long")
		end
	end
end
