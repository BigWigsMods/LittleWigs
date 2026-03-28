--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Crawth", 2526, 2495)
if not mod then return end
mod:RegisterEnableMob(
	191631, -- Ball
	191736  -- Crawth
)
mod:SetEncounterID(2564)
mod:SetRespawnTime(30)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{376760, sound = "info"}, -- Gale Force
		{376997, sound = "alert"}, -- Savage Peck
		{377009, sound = "alarm"}, -- Deafening Screech
	})
end

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_dragonacademy"
end

--------------------------------------------------------------------------------
-- Locals
--

local playBallCount = 1
local searingBlazeGoals = 0
local rushingWindsGoals = 0
local sonicVulnerabilityStacks = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Lish Llrath
		377182, -- Play Ball
		389481, -- Goal of the Searing Blaze
		376448, -- Firestorm
		389483, -- Goal of the Rushing Winds
		376467, -- Gale Force
		-- Crawth
		377034, -- Overpowering Gust
		377004, -- Deafening Screech
		{376997, "TANK_HEALER"}, -- Savage Peck
	}, {
		["warmup"] = CL.general,
		[377182] = 377182, -- Play Ball
		[377034] = self.displayName,
	}
end

function mod:OnBossEnable()
	-- Lish Llrath
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterWidgetEvent(4183, "GoalOfTheSearingBlaze")
	self:Log("SPELL_AURA_APPLIED", "FirestormApplied", 376781)
	self:RegisterWidgetEvent(4184, "GoalOfTheRushingWinds")
	self:Log("SPELL_AURA_APPLIED", "GaleForceApplied", 376760)

	-- Crawth
	self:Log("SPELL_CAST_START", "OverpoweringGust", 377034)
	self:Log("SPELL_CAST_START", "DeafeningScreech", 377004)
	self:Log("SPELL_CAST_START", "SavagePeck", 376997)
end

function mod:OnEngage()
	playBallCount = 1
	searingBlazeGoals = 0
	rushingWindsGoals = 0
	sonicVulnerabilityStacks = 0
	self:StopBar(CL.active)
	self:CDBar(376997, 3.7) -- Savage Peck
	if self:Mythic() then
		self:CDBar(377004, 10.1, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech
	else
		self:CDBar(377004, 10.1) -- Deafening Screech
	end
	self:Bar(377034, 15.8) -- Overpowering Gust
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local savagePeckCount = 1
local deafeningScreechCount = 1
local overpoweringGustCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			"warmup",
			377182, -- Play Ball
			389481, -- Goal of the Searing Blaze
			376448, -- Firestorm
			389483, -- Goal of the Rushing Winds
			376467, -- Gale Force
			377004, -- Deafening Screech
			377034, -- Overpowering Gust
			{376760, "PRIVATE"}, -- Gale Force
			{376997, "PRIVATE"}, -- Savage Peck
			{377009, "PRIVATE"}, -- Deafening Screech
		}
	end

	function mod:OnBossEnable()
		-- Lish Llrath
		self:RegisterWidgetEvent(4183, "GoalOfTheSearingBlaze")
		self:RegisterWidgetEvent(4184, "GoalOfTheRushingWinds")
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		playBallCount = 1
		searingBlazeGoals = 0
		rushingWindsGoals = 0
		savagePeckCount = 1
		deafeningScreechCount = 1
		overpoweringGustCount = 1
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
	local duration = math.floor(eventInfo.duration + 0.5)
	local barInfo
	if duration == 5 then -- Savage Peck
		barInfo = self:SavagePeckTimeline(eventInfo)
	elseif duration == 14 then -- Deafening Screech
		barInfo = self:DeafeningScreechTimeline(eventInfo)
	elseif duration == 20 then -- Overpowering Gust
		barInfo = self:OverpoweringGustTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
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
			-- when all bars are canceled it's because Play Ball is starting
			if not self:IsWiping() then
				self:PlayBall()
			end
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
-- Timeline Ability Handlers
--

function mod:SavagePeckTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(376997), savagePeckCount)
	self:CDBar(376997, eventInfo.duration, barText, nil, eventInfo.id)
	savagePeckCount = savagePeckCount + 1
	return {
		msg = barText,
		key = 376997,
		callback = function()
			self:Message(376997, "purple", barText)
			self:PlaySound(376997, "alert")
		end
	}
end

function mod:DeafeningScreechTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(377004), deafeningScreechCount)
	self:CDBar(377004, eventInfo.duration, barText, nil, eventInfo.id)
	deafeningScreechCount = deafeningScreechCount + 1
	return {
		msg = barText,
		key = 377004,
		callback = function()
			self:Message(377004, "yellow", barText)
			self:PlaySound(377004, "warning")
		end
	}
end

function mod:OverpoweringGustTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(377034), overpoweringGustCount)
	self:CDBar(377034, eventInfo.duration, barText, nil, eventInfo.id)
	overpoweringGustCount = overpoweringGustCount + 1
	return {
		msg = barText,
		key = 377034,
		callback = function()
			self:Message(377034, "orange", barText)
			self:PlaySound(377034, "alarm")
		end
	}
end

do
	local prev = 0
	function mod:PlayBall()
		if GetTime() - prev > 2 and playBallCount < 3 then
			prev = GetTime()
			-- cast at 75% and 45% health
			local percent = playBallCount == 1 and 75 or 45
			playBallCount = playBallCount + 1
			self:Message(377182, "cyan", CL.percent:format(percent, self:SpellName(377182)))
			self:PlaySound(377182, "long")
		end
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	-- this can take slightly longer depending on where Crawth is in her patrol
	self:Bar("warmup", 10.7, CL.active, L.warmup_icon)
end

-- Lish Llrath

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if not self:IsSecret(msg) and msg:find("377182", nil, true) then -- Play Ball
		-- cast at 75% and 45% health
		local percent = playBallCount == 1 and 75 or 45
		playBallCount = playBallCount + 1
		self:Message(377182, "cyan", CL.percent:format(percent, self:SpellName(377182)))
		self:PlaySound(377182, "long")
	end
end

function mod:GoalOfTheSearingBlaze(_, _, info)
	-- [UPDATE_UI_WIDGET] widgetID:4183, shownState:1, text:Goal of the Searing Blaze, barValue:0
	local shownState = info.shownState
	local barValue = info.barValue
	if shownState == 1 and barValue == 3 then
		if not self:Retail() then -- Pre-Midnight
			if self:Mythic() then
				-- reset the count in the Deafening Screech bar back to 1
				local oldBarText = CL.count:format(self:SpellName(377004), sonicVulnerabilityStacks + 1) -- Deafening Screech (n)
				local barTimeLeft = self:BarTimeLeft(oldBarText)
				if barTimeLeft > .1 then
					self:StopBar(oldBarText)
					self:CDBar(377004, {barTimeLeft, 22.7}, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech (1)
				end
			end
			sonicVulnerabilityStacks = 0
		end
		searingBlazeGoals = barValue
		self:Message(376448, "red") -- Firestorm
		self:PlaySound(376448, "long")
	elseif shownState == 1 and barValue > 0 and barValue ~= searingBlazeGoals then
		searingBlazeGoals = barValue
		self:Message(389481, "cyan", CL.count_amount:format(info.text, barValue, 3)) -- Goal of the Searing Blaze (n/3)
		self:PlaySound(389481, "info")
	else
		searingBlazeGoals = barValue
	end
end

function mod:FirestormApplied(args)
	self:Bar(376448, 12, CL.onboss:format(args.spellName))
	self:Message(376448, "green", CL.onboss:format(args.spellName))
	self:PlaySound(376448, "info")
end

function mod:GoalOfTheRushingWinds(_, _, info)
	-- [UPDATE_UI_WIDGET] widgetID:4184, shownState:1, text:Goal of the Rushing Winds, barValue:0
	local shownState = info.shownState
	local barValue = info.barValue
	if shownState == 1 and barValue == 3 then
		if not self:Retail() then -- Pre-Midnight
			if self:Mythic() then
				-- reset the count in the Deafening Screech bar back to 1
				local oldBarText = CL.count:format(self:SpellName(377004), sonicVulnerabilityStacks + 1) -- Deafening Screech (n)
				local barTimeLeft = self:BarTimeLeft(oldBarText)
				if barTimeLeft > .1 then
					self:StopBar(oldBarText)
					self:CDBar(377004, {barTimeLeft, 22.7}, CL.count:format(self:SpellName(377004), 1)) -- Deafening Screech (1)
				end
			end
			sonicVulnerabilityStacks = 0
		end
		rushingWindsGoals = barValue
		self:Message(376467, "red") -- Gale Force
		self:PlaySound(376467, "long")
	elseif shownState == 1 and barValue > 0 and barValue ~= rushingWindsGoals then
		rushingWindsGoals = barValue
		self:Message(389483, "cyan", CL.count_amount:format(info.text, barValue, 3)) -- Goal of the Rushing Winds (n/3)
		self:PlaySound(389483, "info")
	else
		rushingWindsGoals = barValue
	end
end

function mod:GaleForceApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(376467, 20, CL.you:format(args.spellName), args.spellId)
		self:Message(376467, "green", CL.you:format(args.spellName), args.spellId)
		self:PlaySound(376467, "info")
	end
end

-- Crawth

function mod:OverpoweringGust(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 28.6)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DeafeningScreech(args)
	if self:Mythic() then
		-- in Mythic difficulty each subsequent cast does more damage, reset whenever Firestorm or Gale Force are activated
		sonicVulnerabilityStacks = sonicVulnerabilityStacks + 1
		self:Message(args.spellId, "yellow", CL.count:format(CL.casting:format(args.spellName), sonicVulnerabilityStacks))
		self:StopBar(CL.count:format(args.spellName, sonicVulnerabilityStacks))
		self:CDBar(args.spellId, 22.7, CL.count:format(args.spellName, sonicVulnerabilityStacks + 1))
	else
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 22.7)
	end
	self:PlaySound(args.spellId, "warning")
end

function mod:SavagePeck(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 14.6)
	self:PlaySound(args.spellId, "alert")
end
