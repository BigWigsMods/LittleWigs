--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avatar of Sethraliss", 1877, 2145)
if not mod then return end
mod:RegisterEnableMob(133392, 137204) -- Avatar of Sethraliss, Hoodoo Hexer (boss add)
mod:SetEncounterID(2127)
if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRespawnTime(30)
else
	mod:SetRespawnTime(20)
end

--------------------------------------------------------------------------------
-- Locals
--

local stage = 0
local hexerCount = 4

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.heal_boss = "The Avatar can be healed"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true, "boss")
function mod:GetOptions()
	return {
		autotalk,
		"stages",
		"adds",
		268024, -- Pulse
		274149, -- Life Force
		269688, -- Rain of Toads
		{269686, "DISPEL"}, -- Plague
		{268008, "DISPEL"}, -- Snake Charm
		{268007, "TANK"}, -- Heart Attack
	}, {
		["stages"] = "general",
		[268008] = -18295, -- Plague Doctor
	}
end

function mod:OnBossEnable()
	-- The module engages just after the first Taint cast, but Taint increments stage.
	-- The module enables before taint, so it is reset here instead.
	-- The issue is that when the hexers fire INSTANCE_ENCOUNTER_ENGAGE_UNIT,
	-- Unit functions other than UnitGUID don't work on them right away.
	-- UnitHealth will return 0, UnitExists false, etc.
	stage = 0
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_SUCCESS", "Taint", 273677)
	self:Log("SPELL_AURA_APPLIED", "Pulse", 268024)
	self:Log("SPELL_AURA_APPLIED", "Plague", 269686)
	self:Log("SPELL_AURA_REMOVED", "PlagueRemoved", 269686)
	self:Log("SPELL_CAST_START", "SnakeCharm", 268008)
	self:Log("SPELL_AURA_APPLIED", "SnakeCharmApplied", 268008)
	self:Log("SPELL_AURA_APPLIED", "LifeForceApplied", 274149)
	self:Log("SPELL_AURA_APPLIED", "HeartAttack", 268007)

	self:Death("HexerDeath", 137204)
end

function mod:OnEngage()
	self:Bar(268024, 9.5) -- Pulse
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local defilingTaintCount = 1
local stageOneCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[1301202] = {1301202, L.heal_boss, notes = {CL.generalNote, CL.messageCastOverNote}, original = {1301202, CL.removed:format(mod:SpellName(1301202))}}, -- Defiling Taint
		[1273408] = {1273408}, -- Stage One
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			autotalk,
			1301202, -- Defiling Taint
			1273408, -- Stage One
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		defilingTaintCount = 1
		stageOneCount = 1
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
	if duration == 11 then -- Defiling Taint
		barInfo = self:DefilingTaintTimeline(eventInfo)
	elseif duration == 32.5 then -- Stage One
		barInfo = self:StageOneTimeline(eventInfo)
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

function mod:DefilingTaintTimeline(eventInfo) -- Defiling Taint
	local barText = CL.count:format(self:GetRename(1301202), defilingTaintCount)
	self:CDBar(1301202, eventInfo.duration, barText, nil, eventInfo.id)
	defilingTaintCount = defilingTaintCount + 1
	return {
		msg = barText,
		key = 1301202,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1301202, "yellow", barText)
			self:PlaySound(1301202, "alarm")
		end
	}
end

function mod:StageOneTimeline(eventInfo) -- Stage One
	self:StopBlizzMessages(1)
	local barText = CL.count:format(self:GetRename(1273408), stageOneCount)
	self:CDBar(1273408, eventInfo.duration, barText, nil, eventInfo.id)
	stageOneCount = stageOneCount + 1
	self:Message(1301202, "green", self:GetRename(1301202, 2)) -- The Avatar can be healed (Defiling Taint removed)
	self:PlaySound(1301202, "info")
	return {
		msg = barText,
		key = 1273408,
		callback = function()
			self:Message(1273408, "cyan", barText)
			self:PlaySound(1273408, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW() -- called from Trash module
	if self:GetOption(autotalk) and self:GetGossipID(107065) then
		self:SelectGossipID(107065)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if not self:IsSecret(msg) and msg:find("269688", nil, true) then -- Rain of Toads
		self:Message(269688, "orange")
		self:PlaySound(269688, "info")
	end
end

do
	local function warnHeartGuardian()
		mod:Message("adds", "orange", CL.spawned:format(mod:SpellName(-18205)), false) -- Heart Guardian
		mod:PlaySound("adds", "warning")
	end

	local function warnPlagueDoctor()
		mod:Message("adds", "orange", CL.spawned:format(mod:SpellName(-18295)), false) -- Plague Doctor
		mod:PlaySound("adds", "warning")
	end

	local prev = 0
	function mod:Taint(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			stage = stage + 1
			hexerCount = 4

			local plagueDoctorSpawning = CL.spawning:format(self:SpellName(-18295))
			local heartGuardianSpawning = CL.spawning:format(self:SpellName(-18205))
			if stage == 3 then
				self:Bar("adds", 2.5, heartGuardianSpawning, 268007) -- Heart Guardian, Heart Attack
				self:SimpleTimer(warnHeartGuardian, 2.5)
				if not self:Normal() then
					self:Bar("adds", 3.5, plagueDoctorSpawning, 268008) -- Snake Charm icon
					self:SimpleTimer(warnPlagueDoctor, 3.5)
					self:ScheduleTimer("Bar", 3.5, "adds", 6, plagueDoctorSpawning, 268008) -- Snake Charm icon, 9.5 sec total
					self:SimpleTimer(warnPlagueDoctor, 9.5)
				end
			else -- Stage 1 or 2
				self:Bar("adds", 3.5, heartGuardianSpawning, 268007) -- Heart Guardian, Heart Attack
				self:SimpleTimer(warnHeartGuardian, 3.5)
				if not self:Normal() then
					self:Bar("adds", 16.5, plagueDoctorSpawning, 268008) -- Snake Charm icon
					self:SimpleTimer(warnPlagueDoctor, 16.5)
				end
			end
			if stage ~= 1 then -- Don't show on pull
				self:Message("stages", "cyan", CL.over:format(CL.intermission), false)
				self:PlaySound("stages", "long")
			end
		end
	end
end

do
	local prev = 0
	function mod:Pulse(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			if self:Healer() then
				self:Message(args.spellId, "yellow")
				self:PlaySound(args.spellId, "alert")
			end
			self:Bar(args.spellId, 15)
		end
	end
end

function mod:Plague(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:TargetBar(args.spellId, 12, args.destName)
	end
end

function mod:PlagueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SnakeCharm(args)
	if not self.isEngaged then return end -- Trash before the boss casts the same spell
	if self:Interrupter() then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SnakeCharmApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:LifeForceApplied(args)
	self:TargetMessage(args.spellId, "green", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:HeartAttack(args)
	if not self.isEngaged then return end -- Trash before the boss casts the same spell
	self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:HexerDeath(args)
	hexerCount = hexerCount - 1
	if hexerCount > 0 then
		self:Message("stages", "cyan", CL.add_remaining:format(hexerCount), false)
		self:PlaySound("stages", "info")
	elseif stage ~= 3 then -- 3 is the last phase
		self:Message("stages", "cyan", CL.intermission, false)
		self:PlaySound("stages", "long")
		self:StopBar(268024) -- Pulse
	end
end
