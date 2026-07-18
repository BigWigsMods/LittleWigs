--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Melidrussa Chillworn", 2521, 2488)
if not mod then return end
mod:RegisterEnableMob(188252) -- Melidrussa Chillworn
mod:SetEncounterID(2609)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local awakenWhelpsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373046, -- Awaken Whelps
		{372682, "DISPEL"}, -- Primal Chill
		{372851, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Chillstorm
		396044, -- Hailbombs
		372988, -- Ice Bulwark
		373680, -- Frost Overload
	}, {
		[372988] = CL.mythic,
	}, {
		[372851] = CL.knockback,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AwakenWhelps", 373046)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PrimalChillApplied", 372682)
	self:Log("SPELL_AURA_APPLIED", "Chillstorm", 385518)
	self:Log("SPELL_AURA_REMOVED", "ChillstormRemoved", 385518)
	self:Log("SPELL_CAST_SUCCESS", "Hailbombs", 396044)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "IceBulwarkApplied", 372988)
	self:Log("SPELL_AURA_REMOVED", "IceBulwarkRemoved", 372988)
	self:Log("SPELL_AURA_APPLIED", "FrostOverload", 373680)
	self:Log("SPELL_AURA_REMOVED", "FrostOverloadOver", 373680)
end

function mod:OnEngage()
	awakenWhelpsCount = 1
	self:SetStage(1)
	self:CDBar(396044, 6.8) -- Hailbombs
	self:CDBar(372851, 12.1) -- Chillstorm
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local hailburstCount = 1
local chillstormCount = 1
local frostOverloadCount = 1
local count27 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[1307297] = {1307297}, -- Hailburst
		[1307308] = {1307308, CL.you:format(mod:SpellName(1307308)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1307308, CL.you:format(mod:SpellName(1307308))}}, -- Chillstorm
		[373046] = {373046}, -- Awaken Whelps
		[373686] = {373686, CL.over:format(mod:SpellName(373686)), notes = {CL.generalNote, CL.messageNote}, original = {373686, CL.over:format(mod:SpellName(373686))}}, -- Frost Overload
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			1307297, -- Hailburst
			1307308, -- Chillstorm
			373046, -- Awaken Whelps
			373686, -- Frost Overload
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		hailburstCount = 1
		chillstormCount = 1
		awakenWhelpsCount = 1
		frostOverloadCount = 1
		count27 = 1
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
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 6 or (duration == 27 and count27 % 2 == 1) then -- Hailburst
		barInfo = self:HailburstTimeline(eventInfo)
	elseif duration == 16 or (duration == 27 and count27 % 2 == 0) then -- Chillstorm
		barInfo = self:ChillstormTimeline(eventInfo)
	elseif duration == 12 then -- Frost Overload
		barInfo = self:FrostOverloadTimeline(eventInfo)
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
	if duration == 27 then count27 = count27 + 1 end
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

function mod:HailburstTimeline(eventInfo) -- Hailburst
	if self:GetStage() == 2 then
		self:SetStage(1)
		self:Message(373686, "green", self:GetRename(373686, 2)) -- Frost Overload over
		self:PlaySound(373686, "info")
	end
	local barText = CL.count:format(self:GetRename(1307297), hailburstCount)
	self:CDBar(1307297, eventInfo.duration, barText, nil, eventInfo.id)
	hailburstCount = hailburstCount + 1
	return {
		msg = barText,
		key = 1307297,
		callback = function()
			self:Message(1307297, "orange", barText)
			self:PlaySound(1307297, "alarm")
		end,
		cancelCallback = function()
			hailburstCount = hailburstCount - 1
		end
	}
end

function mod:ChillstormTimeline(eventInfo) -- Chillstorm
	local barText = CL.count:format(self:GetRename(1307308), chillstormCount)
	self:CDBar(1307308, eventInfo.duration, barText, nil, eventInfo.id)
	chillstormCount = chillstormCount + 1
	return {
		msg = barText,
		key = 1307308,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1307308, 1, false, self:GetRename(1307308, 2)) -- TODO confirm
			self:Message(1307308, "yellow", barText)
			self:PlaySound(1307308, "alert")
		end,
		cancelCallback = function()
			chillstormCount = chillstormCount - 1
		end
	}
end

function mod:FrostOverloadTimeline(eventInfo) -- Frost Overload
	self:SetStage(2)
	self:StopBlizzMessages(1)
	local barText = CL.count:format(self:GetRename(373686), frostOverloadCount)
	self:CDBar(373686, eventInfo.duration, barText, nil, eventInfo.id)
	frostOverloadCount = frostOverloadCount + 1
	self:Message(373046, "cyan", CL.percent:format(awakenWhelpsCount == 1 and 66 or 33, self:GetRename(373046))) -- Awaken Whelps
	awakenWhelpsCount = awakenWhelpsCount + 1
	self:PlaySound(373046, "info") -- Awaken Whelps
	return {
		msg = barText,
		key = 373686,
		callback = function()
			self:Message(373686, "red", barText)
			self:PlaySound(373686, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenWhelps(args)
	local percent = awakenWhelpsCount == 1 and 75 or 45
	awakenWhelpsCount = awakenWhelpsCount + 1
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	self:PlaySound(args.spellId, "info")
	if self:Mythic() then
		self:SetStage(2)
		self:CDBar(373680, 8.5) -- Frost Overload
		self:StopBar(396044) -- Hailbombs
		self:StopBar(372851) -- Chillstorm
	end
end

do
	local prev = 0
	function mod:PrimalChillApplied(args)
		-- stuns at 8 stacks on mythic, 10 stacks in normal/heroic
		local primalChillMax = self:Mythic() and 8 or 10
		local emphasizeAmount = self:Mythic() and 6 or 8
		local amount = args.amount
		-- start warning at half the required stacks to stun
		local aboveThreshold = amount >= primalChillMax / 2 and amount < primalChillMax
		local shouldWarn = self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) or self:Me(args.destGUID)
		if aboveThreshold and shouldWarn then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:StackMessage(args.spellId, "red", args.destName, amount, emphasizeAmount)
				if amount >= emphasizeAmount then
					self:PlaySound(args.spellId, "warning", nil, args.destName)
				else
					self:PlaySound(args.spellId, "alert", nil, args.destName)
				end
			end
		end
	end
end

function mod:Chillstorm(args)
	self:TargetMessage(372851, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(372851, "alarm", nil, args.destName)
		self:Say(372851, nil, nil, "Chillstorm")
		self:SayCountdown(372851, 3.5, nil, 2)
	else
		self:PlaySound(372851, "alert", nil, args.destName)
	end
	self:CDBar(372851, 23.1)
end

function mod:ChillstormRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(372851)
	end
	self:Bar(372851, 6, CL.knockback)
end

function mod:Hailbombs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.1)
end

-- Mythic

do
	local iceBulwarkStart = 0

	function mod:IceBulwarkApplied(args)
		iceBulwarkStart = args.time
	end

	function mod:IceBulwarkRemoved(args)
		local iceBulwarkDuration = args.time - iceBulwarkStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, iceBulwarkDuration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:FrostOverload(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:FrostOverloadOver(args)
	self:SetStage(1)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CDBar(396044, 6) -- Hailbombs
	self:CDBar(372851, 12.1) -- Chillstorm
end
