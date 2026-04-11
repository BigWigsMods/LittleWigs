--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overgrown Ancient", 2526, 2512)
if not mod then return end
mod:RegisterEnableMob(196482) -- Overgrown Ancient
mod:SetEncounterID(2563)
mod:SetRespawnTime(30)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{388544, sound = "alarm"}, -- Barkbreaker
		{389033, sound = "none"}, -- Lasher Toxin
		{396716, sound = "long"}, -- Splinterbark
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

local germinateCount = 1
local burstForthCount = 1
local branchOutCount = 1
local barkbreakerCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"warmup",
		-- Overgrown Ancient
		388796, -- Germinate
		388923, -- Burst Forth
		388623, -- Branch Out
		{388544, "TANK_HEALER"}, -- Barkbreaker
		-- Hungry Lasher
		{389033, "DISPEL"}, -- Lasher Toxin (Mythic only)
		-- Ancient Branch
		396640, -- Healing Touch
		{396721, "CASTBAR"}, -- Abundance
	}, {
		["warmup"] = CL.general,
		[388796] = self.displayName,
		[389033] = -25730, -- Hungry Lasher
		[396640] = -25688, -- Ancient Branch
	}
end

function mod:OnBossEnable()
	-- Overgrown Ancient
	self:Log("SPELL_CAST_SUCCESS", "Germinate", 388796)
	self:Log("SPELL_CAST_START", "BurstForth", 388923)
	self:Log("SPELL_CAST_START", "BranchOut", 388623)
	self:Log("SPELL_CAST_START", "Barkbreaker", 388544)

	-- Hungry Lasher
	self:Log("SPELL_AURA_APPLIED_DOSE", "LasherToxinApplied", 389033)

	-- Ancient Branch
	self:Log("SPELL_CAST_START", "HealingTouch", 396640)
	self:Death("AncientBranchDeath", 196548)
end

function mod:OnEngage()
	germinateCount = 1
	burstForthCount = 1
	branchOutCount = 1
	barkbreakerCount = 1
	self:StopBar(CL.active) -- Warmup
	self:CDBar(388544, 9.7) -- Barkbreaker
	self:CDBar(388796, 18.2) -- Germinate
	if not self:Normal() then
		self:CDBar(388623, 30.4) -- Branch Out
	end
	self:CDBar(388923, 56.4, CL.count:format(self:SpellName(388923), burstForthCount)) -- Burst Forth
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			"warmup",
			388796, -- Germinate
			388923, -- Burst Forth
			388623, -- Branch Out
			{388544, "TANK_HEALER"}, -- Barkbreaker
			{389033, "PRIVATE"}, -- Lasher Toxin
			{396716, "PRIVATE"}, -- Splinterbark
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		germinateCount = 1
		burstForthCount = 1
		branchOutCount = 1
		barkbreakerCount = 1
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
	if duration == 9 or duration == 28 or duration == 29 then -- Barkbreaker
		barInfo = self:BarkbreakerTimeline(eventInfo)
	elseif duration == 18 or duration == 33 then -- Germinate
		barInfo = self:GerminateTimeline(eventInfo)
	elseif not self:IsWiping() and duration == 30 then -- Branch Out
		barInfo = self:BranchOutTimeline(eventInfo)
	elseif duration == 54 or duration == 55 then -- Burst Forth
		barInfo = self:BurstForthTimeline(eventInfo)
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
				-- we need a special check for Germinate/Barkbreaker because in Normal random bars are started and finished after a few seconds
				if (barInfo.key ~= 388796 and barInfo.key ~= 388544) or GetTime() - barInfo.time > 6 then
					barInfo.callback()
				end
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

function mod:GerminateTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(388796), germinateCount)
	self:CDBar(388796, eventInfo.duration, barText, nil, eventInfo.id)
	germinateCount = germinateCount + 1
	return {
		msg = barText,
		key = 388796,
		time = GetTime(),
		callback = function()
			self:Message(388796, "yellow", barText)
			self:PlaySound(388796, "long")
		end
	}
end

function mod:BurstForthTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(388923), burstForthCount)
	self:CDBar(388923, eventInfo.duration, barText, nil, eventInfo.id)
	burstForthCount = burstForthCount + 1
	return {
		msg = barText,
		key = 388923,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(388923, "orange", barText)
			self:PlaySound(388923, "long")
		end
	}
end

function mod:BranchOutTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(388623), branchOutCount)
	self:CDBar(388623, eventInfo.duration, barText, nil, eventInfo.id)
	branchOutCount = branchOutCount + 1
	return {
		msg = barText,
		key = 388623,
		callback = function()
			self:Message(388623, "red", barText)
			self:PlaySound(388623, "alarm")
		end
	}
end

do
	local prev = 0
	function mod:BarkbreakerTimeline(eventInfo)
		local barText = CL.count:format(self:SpellName(388544), barkbreakerCount)
		self:CDBar(388544, eventInfo.duration, barText, nil, eventInfo.id)
		barkbreakerCount = barkbreakerCount + 1
		return {
			msg = barText,
			key = 388544,
			time = GetTime(),
			callback = function()
				-- sometimes Blizzard likes to start 2 bars for this ability at the same time with the same duration
				if GetTime() - prev > 2 then
					prev = GetTime()
					self:Message(388544, "purple", barText)
					self:PlaySound(388544, "alert")
				end
			end
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 16.8, CL.active, L.warmup_icon)
end

-- Overgrown Ancient

function mod:Germinate(args)
	self:Message(args.spellId, "yellow")
	germinateCount = germinateCount + 1
	-- 18.3, 34.0, 25.5, 34.0, 25.5 pattern
	self:CDBar(args.spellId, germinateCount % 2 == 0 and 34.0 or 25.5)
	self:PlaySound(args.spellId, "long")
end

function mod:BurstForth(args)
	local burstForthMessage = CL.count:format(args.spellName, burstForthCount)
	self:StopBar(burstForthMessage)
	self:Message(args.spellId, "orange", burstForthMessage)
	burstForthCount = burstForthCount + 1
	-- cast at 100 energy, 2s cast + 54s energy gain + delay
	self:CDBar(args.spellId, 59.5, CL.count:format(args.spellName, burstForthCount))
	self:PlaySound(args.spellId, "long")
end

function mod:BranchOut(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 59.5)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Barkbreaker(args)
	self:Message(args.spellId, "purple")
	barkbreakerCount = barkbreakerCount + 1
	-- 10.7, 29.1, 30.4, 29.1, 30.4, 29.1
	self:CDBar(args.spellId, barkbreakerCount % 2 == 0 and 29.1 or 30.4)
	self:PlaySound(args.spellId, "alert")
end

-- Hungry Lasher

do
	local prev = 0
	function mod:LasherToxinApplied(args)
		if args.amount >= 5 and args.amount % 5 == 0 and self:Dispeller("poison", nil, args.spellId) then
			-- this can sometimes apply rapidly or to more than one person, so add a short throttle.
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:StackMessage(args.spellId, "red", args.destName, args.amount, 10)
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

-- Ancient Branch

function mod:HealingTouch(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:AncientBranchDeath(args)
	if self:Mythic() then
		self:Message(396721, "green") -- Abundance
		self:CastBar(396721, 3.5)
		self:PlaySound(396721, "info")
	end
end
