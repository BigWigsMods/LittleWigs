if not BigWigsLoader.isNext then return end -- 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rav'i", 2993, 2878)
if not mod then return end
mod:SetEncounterID(3456)
mod:SetRespawnTime(30)
--mod:SetPrivateAuraSounds({})
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local tripleShotCount = 1
local freshMeatCount = 1
local ssscavengingCount = 1
--local feedingFrenzyCount = 1
local regurgitateCount = 1
local ravenousStompCount = 2
local count24 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1296220] = {1296220, CL.you:format(mod:SpellName(1296220)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1296220, CL.you:format(mod:SpellName(1296220))}}, -- Triple Shot
	[1307703] = {1307703}, -- Fresh Meat
	[1296216] = {1296216}, -- Ssscavenging
	--[1307765] = {1307765}, -- Feeding Frenzy
	[1296050] = {1296050}, -- Regurgitate
	[1307894] = {1307894}, -- Ravenous Stomp
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1296220, -- Triple Shot
		1307703, -- Fresh Meat
		1296216, -- Ssscavenging
		--1307765, -- Feeding Frenzy
		1296050, -- Regurgitate
		1307894, -- Ravenous Stomp
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	tripleShotCount = 1
	freshMeatCount = 1
	ssscavengingCount = 1
	--feedingFrenzyCount = 1
	regurgitateCount = 1
	ravenousStompCount = 2 -- cast on pull
	count24 = 1
	activeBars = {}
	backupBars = {}
	self:SetStage(1)
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		self:SendMessage("BigWigs_BlockBlizzMessages")
		self:RegisterEvent("ENCOUNTER_WARNING")
		self:CDBar(1307703, 6, CL.count:format(self:GetRename(1307703), freshMeatCount)) -- Fresh Meat
		self:RavenousStomp(CL.count:format(self:GetRename(1307894), 1)) -- Ravenous Stomp is cast on pull
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

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 8 or (duration == 24 and count24 % 2 == 0) then -- Triple Shot
		barInfo = self:TripleShotTimeline(eventInfo)
	elseif duration == 25 or duration == 45 then -- Ssscavenging
		barInfo = self:SsscavengingTimeline(eventInfo)
	elseif duration == 13 then -- Regurgitate
		barInfo = self:RegurgitateTimeline(eventInfo)
	elseif (duration == 24 and count24 % 2 == 1) then -- Ravenous Stomp
		barInfo = self:RavenousStompTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 24 then
		count24 = count24 + 1
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

function mod:ENCOUNTER_WARNING(_, info)
	if info.severity == 0 then -- Triple Shot (LOW)
		self:PersonalMessage(1296220, false, self:GetRename(1296220, 2))
		self:PlaySound(1296220, "warning", nil, self:UnitName("player"))
	elseif info.severity == 1 then -- Fresh Meat (MEDIUM)
		local barText = CL.count:format(self:GetRename(1307703), freshMeatCount)
		self:StopBar(barText)
		freshMeatCount = freshMeatCount + 1
		self:Message(1307703, "purple", barText)
		self:PlaySound(1307703, "info")
	--elseif info.severity == 2 then -- Ssscavenging (HIGH)
	end
end

function mod:TripleShotTimeline(eventInfo) -- Triple Shot
	if self:GetStage() == 2 then
		self:SetStage(1)
		self:CDBar(1307703, 30, CL.count:format(self:GetRename(1307703), freshMeatCount)) -- Fresh Meat
	end
	local barText = CL.count:format(self:GetRename(1296220), tripleShotCount)
	self:CDBar(1296220, eventInfo.duration, barText, nil, eventInfo.id)
	tripleShotCount = tripleShotCount + 1
	return {
		msg = barText,
		key = 1296220,
		callback = function()
			-- there is a :PersonalMessage at the end of this 2s cast, handled in ENCOUNTER_WARNING
			self:Message(1296220, "yellow", barText)
			self:PlaySound(1296220, "alert")
		end
	}
end

--function mod:CHAT_MSG_MONSTER_EMOTE(event) -- Feeding Frenzy
	--self:UnregisterEvent(event)
	--local msg = CL.count:format(self:GetRename(1307765), feedingFrenzyCount)
	--self:Message(1307765, "red", msg)
	--feedingFrenzyCount = feedingFrenzyCount + 1
	--self:PlaySound(1307765, "warning")
--end

function mod:SsscavengingTimeline(eventInfo) -- Ssscavenging
	local barText = CL.count:format(self:GetRename(1296216), ssscavengingCount)
	self:CDBar(1296216, eventInfo.duration, barText, nil, eventInfo.id)
	ssscavengingCount = ssscavengingCount + 1
	return {
		msg = barText,
		key = 1296216,
		callback = function()
			self:SetStage(2)
			self:Message(1296216, "cyan", barText)
			-- if there's a CHAT_MSG_MONSTER_EMOTE within a few seconds, it means the mechanic was (probably) failed.
			-- this should probably be ENCOUNTER_WARNING. (if it's changed, our Fresh Meat handler will need to be adjusted)
			--self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
			-- to make this reliable enough maybe we could look for a Ssscavenging (here) -> UNIT_SPELLCAST_CHANNEL_START[boss1] -> CHAT_MSG_MONSTER_EMOTE combo
			-- in the non-fail case the only thing missing is the CHAT_MSG_MONSTER_EMOTE
			self:PlaySound(1296216, "long")
		end
	}
end

function mod:RegurgitateTimeline(eventInfo) -- Regurgitate
	local barText = CL.count:format(self:GetRename(1296050), regurgitateCount)
	self:CDBar(1296050, eventInfo.duration, barText, nil, eventInfo.id)
	regurgitateCount = regurgitateCount + 1
	return {
		msg = barText,
		key = 1296050,
		callback = function()
			self:Message(1296050, "orange", barText)
			self:PlaySound(1296050, "alarm")
		end
	}
end

function mod:RavenousStomp(barText)
	self:Message(1307894, "red", barText)
	self:PlaySound(1307894, "alarm")
end

function mod:RavenousStompTimeline(eventInfo) -- Ravenous Stomp
	local barText = CL.count:format(self:GetRename(1307894), ravenousStompCount)
	self:CDBar(1307894, eventInfo.duration, barText, nil, eventInfo.id)
	ravenousStompCount = ravenousStompCount + 1
	return {
		msg = barText,
		key = 1307894,
		callback = function()
			self:RavenousStomp(barText)
		end
	}
end
