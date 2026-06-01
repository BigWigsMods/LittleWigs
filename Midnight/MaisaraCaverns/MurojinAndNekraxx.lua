--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Muro'jin and Nekraxx", 2874, 2810)
if not mod then return end
mod:SetEncounterID(3212)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1243741, sound = "none", note = CL.debuffWalkIntoObjectNote:format(mod:SpellName(1266480))}, -- Freezing Trap
	{1243752, sound = "underyou", note = CL.debuffUnderYouNote}, -- Icy Slick
	{1246666, sound = "none", note = CL.disease}, -- Infected Pinions
	{1249478, sound = "warning", note = CL.charge}, -- Carrion Swoop
	{1260643, sound = "warning"}, -- Barrage
	{1266488, sound = "alert", note = CL.debuffTankAfterCastNote:format(CL.extra:format(mod:SpellName(1266480), CL.tank_knockback))}, -- Open Wound
})

--------------------------------------------------------------------------------
-- Locals
--

local flankingSpearCount = 1
local infectedPinionsCount = 1
local freezingTrapCount = 1
local fetidQuillstormCount = 1
local barrageCount = 1
local carrionSwoopCount = 1
local count45 = 1
local murojinAlive = true
local resuming = 0
local lastCanceledTime = 0
local activeBars = {}
local canceledBars = {}
local canceledBarsCount = 0
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	-- Muro'jin
	[1260731] = {CL.traps}, -- Freezing Trap (Traps)
	[1260643] = {1260643, CL.you:format(mod:SpellName(1260643)), notes = {CL.generalNote, CL.messageOnYouNote}, original = false}, -- Barrage
	[1266480] = {CL.tank_knockback}, -- Flanking Spear (Tank Knockback)
	-- Nekraxx
	[1249479] = {CL.charge}, -- Carrion Swoop (Charge)
	[1243900] = {CL.dodge}, -- Fetid Quillstorm (Dodge)
	[1246666] = {CL.disease}, -- Infected Pinions (Disease)
	[1249947] = {1249947}, -- Bestial Wrath
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Muro'jin
		1260731, -- Freezing Trap
		{1260643, "ME_ONLY_EMPHASIZE"}, -- Barrage
		1266480, -- Flanking Spear
		-- Nekraxx
		1249479, -- Carrion Swoop
		1243900, -- Fetid Quillstorm
		1246666, -- Infected Pinions
		1249947, -- Bestial Wrath
	},{
		[1260731] = -33932, -- Muro'jin
		[1249479] = -33935, -- Nekraxx
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	flankingSpearCount = 1
	infectedPinionsCount = 1
	freezingTrapCount = 1
	fetidQuillstormCount = 1
	barrageCount = 1
	carrionSwoopCount = 1
	count45 = 1
	murojinAlive = true
	resuming = 0
	lastCanceledTime = 0
	activeBars = {}
	canceledBars = {}
	canceledBarsCount = 0
	backupBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

function mod:OnWin()
	resuming = 0
	lastCanceledTime = 0
	activeBars = {}
	canceledBars = {}
	canceledBarsCount = 0
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
	local threshold = 1 -- only match if within 1 second of expected duration (usually within 0.03)
	for key, originalExpirationTime in pairs(canceledBars) do
		local diff = math.abs(originalExpirationTime - lastCanceledTime - duration + 3) -- Blizz adds 3s
		if diff < minDiff and diff <= threshold then
			minDiff = diff
			closestKey = key
		end
	end
	if closestKey then
		canceledBars[closestKey] = nil
	end
	return closestKey
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	-- only try to resume bars if all 6 bars have been canceled and there are still bars left to resume
	if resuming > 0 and canceledBarsCount % 6 == 0 then
		local resumingSpell = self:GetClosestSpell(eventInfo.duration)
		if resumingSpell == 1266480 then -- Flanking Spear
			resuming = resuming - 1
			barInfo = self:FlankingSpearTimeline(eventInfo)
		elseif resumingSpell == 1246666 then -- Infected Pinions
			resuming = resuming - 1
			barInfo = self:InfectedPinionsTimeline(eventInfo)
		elseif resumingSpell == 1260731 then -- Freezing Trap
			resuming = resuming - 1
			barInfo = self:FreezingTrapTimeline(eventInfo)
		elseif resumingSpell == 1243900 then -- Fetid Quillstorm
			resuming = resuming - 1
			barInfo = self:FetidQuillstormTimeline(eventInfo)
		elseif resumingSpell == 1260643 then -- Barrage
			resuming = resuming - 1
			barInfo = self:BarrageTimeline(eventInfo)
		elseif resumingSpell == 1249479 then -- Carrion Swoop
			resuming = resuming - 1
			barInfo = self:CarrionSwoopTimeline(eventInfo)
		elseif not self:IsWiping() then
			resuming = resuming - 1
			self:ErrorForTimelineEvent(eventInfo)
			backupBars[eventInfo.id] = true
			self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		end
		if resuming == 0 then
			-- if all bars have been resumed (or backups started), clear the state
			canceledBarsCount = 0
			canceledBars = {}
		end
	elseif duration == 5 or (duration == 45 and count45 % 6 == 1) then -- Flanking Spear (Muro'jin)
		barInfo = self:FlankingSpearTimeline(eventInfo)
	elseif duration == 12 or (duration == 45 and count45 % 6 == 2) then -- Infected Pinions (Nekraxx)
		barInfo = self:InfectedPinionsTimeline(eventInfo)
	elseif duration == 20 or (duration == 45 and count45 % 6 == 3) then -- Freezing Trap (Muro'jin)
		barInfo = self:FreezingTrapTimeline(eventInfo)
	elseif duration == 28 or (duration == 45 and count45 % 6 == 4) then -- Fetid Quillstorm (Nekraxx)
		barInfo = self:FetidQuillstormTimeline(eventInfo)
	elseif duration == 35 or (duration == 45 and count45 % 6 == 5) then -- Barrage (Muro'jin)
		barInfo = self:BarrageTimeline(eventInfo)
	elseif duration == 41 or (duration == 45 and count45 % 6 == 0) then -- Carrion Swoop (Nekraxx)
		barInfo = self:CarrionSwoopTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
	end
	if duration == 45 then
		if murojinAlive then
			count45 = count45 + 1
		else -- increment counter by 2 to skip the dead boss's abilities
			count45 = count45 + 2
		end
	end
	if barInfo then
		barInfo.expirationTime = GetTime() + eventInfo.duration
		activeBars[eventInfo.id] = barInfo
	end
end

do
	local murojinAbilities = {
		[1266480] = true, -- Flanking Spear
		[1260731] = true, -- Freezing Trap
		[1260643] = true, -- Barrage
	}
	local nekraxxAbilities = {
		[1246666] = true, -- Infected Pinions
		[1243900] = true, -- Fetid Quillstorm
		[1249479] = true, -- Carrion Swoop
	}
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
				lastCanceledTime = GetTime()
				canceledBars[barInfo.key] = barInfo.expirationTime
				canceledBarsCount = canceledBarsCount + 1
				activeBars[eventID] = nil
				if murojinAbilities[barInfo.key] and resuming == 0 then
					-- if Nekraxx is killed then Nekraxx's abilities will always be canceled first, so if resuming is 0 then
					-- Muro'jin is definitely dead.
					if murojinAlive then
						murojinAlive = false
						if count45 % 2 == 1 then -- if Muro'jin died when his ability was next, increment the counter to skip it
							count45 = count45 + 1
						end
						self:BestialWrath()
					end
				elseif nekraxxAbilities[barInfo.key] then
					resuming = 6
				end
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

function mod:FlankingSpearTimeline(eventInfo) -- Tank Knockback
	local barText = CL.count:format(self:GetRename(1266480), flankingSpearCount)
	self:CDBar(1266480, eventInfo.duration, barText, nil, eventInfo.id)
	flankingSpearCount = flankingSpearCount + 1
	return {
		msg = barText,
		key = 1266480,
		callback = function()
			self:Message(1266480, "purple", barText)
			self:PlaySound(1266480, "alert")
		end,
		cancelCallback = function()
			flankingSpearCount = flankingSpearCount - 1
		end
	}
end

function mod:InfectedPinionsTimeline(eventInfo) -- Disease
	local barText = CL.count:format(self:GetRename(1246666), infectedPinionsCount)
	self:CDBar(1246666, eventInfo.duration, barText, nil, eventInfo.id)
	infectedPinionsCount = infectedPinionsCount + 1
	return {
		msg = barText,
		key = 1246666,
		callback = function()
			self:Message(1246666, "yellow", barText)
			self:PlaySound(1246666, "alert")
		end,
		cancelCallback = function()
			infectedPinionsCount = infectedPinionsCount - 1
		end
	}
end

function mod:FreezingTrapTimeline(eventInfo) -- Traps
	local barText = CL.count:format(self:GetRename(1260731), freezingTrapCount)
	self:CDBar(1260731, eventInfo.duration, barText, nil, eventInfo.id)
	freezingTrapCount = freezingTrapCount + 1
	return {
		msg = barText,
		key = 1260731,
		callback = function()
			self:Message(1260731, "orange", barText)
			self:PlaySound(1260731, "alarm")
		end,
		cancelCallback = function()
			freezingTrapCount = freezingTrapCount - 1
		end
	}
end

function mod:FetidQuillstormTimeline(eventInfo) -- Dodge
	local barText = CL.count:format(self:GetRename(1243900), fetidQuillstormCount)
	self:CDBar(1243900, eventInfo.duration, barText, nil, eventInfo.id)
	fetidQuillstormCount = fetidQuillstormCount + 1
	return {
		msg = barText,
		key = 1243900,
		callback = function()
			self:Message(1243900, "yellow", barText)
			self:PlaySound(1243900, "long")
		end,
		cancelCallback = function()
			fetidQuillstormCount = fetidQuillstormCount - 1
		end
	}
end

function mod:BarrageTimeline(eventInfo) -- Barrage / Frontal Cone
	local barText = CL.count:format(self:GetRename(1260643), barrageCount)
	self:CDBar(1260643, eventInfo.duration, barText, nil, eventInfo.id)
	barrageCount = barrageCount + 1
	return {
		msg = barText,
		key = 1260643,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1260643, 1, false, self:GetRename(1260643, 2))
			self:Message(1260643, "yellow", barText)
			--self:PlaySound(1260643, "warning") -- PA sound
		end,
		cancelCallback = function()
			barrageCount = barrageCount - 1
		end
	}
end

function mod:CarrionSwoopTimeline(eventInfo) -- Charge
	local barText = CL.count:format(self:GetRename(1249479), carrionSwoopCount)
	self:CDBar(1249479, eventInfo.duration, barText, nil, eventInfo.id)
	carrionSwoopCount = carrionSwoopCount + 1
	return {
		msg = barText,
		key = 1249479,
		callback = function()
			self:TargetMessageFromBlizzMessage(1249479, 1, "red")
			--self:PlaySound(1249479, "warning") -- PA sound
		end,
		cancelCallback = function()
			carrionSwoopCount = carrionSwoopCount - 1
		end
	}
end

function mod:BestialWrath() -- Bestial Wrath / Enrage
	self:Message(1249947, "cyan")
	self:PlaySound(1249947, "long")
end
