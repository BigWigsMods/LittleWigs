--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Adderis and Aspix", 1877, 2142)
if not mod then return end
mod:RegisterEnableMob(133379, 133944) -- Adderis, Aspix
mod:SetEncounterID(2124)
if mod:Retail() then -- Midnight+
	mod:SetRespawnTime(30)
else
	mod:SetRespawnTime(20)
end

--------------------------------------------------------------------------------
-- Locals
--

local cycloneStrikeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{263246, "ICON"}, -- Lightning Shield
		{263257, "CASTBAR"}, -- Static Shock
		{263371, "SAY", "SAY_COUNTDOWN"}, -- Conduction
		263424, -- Arc Dash
		{263309, "SAY", "FLASH", "CASTBAR"}, -- Cyclone Strike
	}, {
		[263246] = "general",
		[263257] = -18484, -- Aspix
		[263424] = -18485, -- Adderis
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "LightningShield", 263246)
	self:Log("SPELL_AURA_APPLIED", "Conduction", 263371)
	self:Log("SPELL_AURA_REMOVED", "ConductionRemoved", 263371)
	self:Log("SPELL_CAST_START", "CycloneStrike", 263309)
	self:Log("SPELL_CAST_START", "StaticShock", 263257)
	self:Death("BossDeath", 133379, 133944)
end

function mod:OnEngage()
	cycloneStrikeCount = 0
	self:Bar(263309, 8.5) -- Cyclone Strike
	self:Bar(263371, 22.5) -- Conduction
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local stormBlessedCount = 1
local galeForceCount = 1
local thunderAndLightningCount = 1
local tempestWindsCount = 1
local overloadCount = 1
local count45 = 1
local count19 = 1
local adderisDead = false
local aspixDead = false
local boss2Seen = false
local bossDeathTime = 0
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if mod:Retail() then -- Midnight+
	mod:SetRenames({
		[1310311] = {CL.on:format(mod:SpellName(1310311), mod:SpellName(-18485)), CL.on:format(mod:SpellName(1310311), mod:SpellName(-18484)), original = {CL.on:format(mod:SpellName(1310311), mod:SpellName(-18485)), CL.on:format(mod:SpellName(1310311), mod:SpellName(-18484))}}, -- Storm Blessed
		[1289059] = {1289059, CL.you:format(mod:SpellName(1289059)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1289059, CL.you:format(mod:SpellName(1289059))}}, -- Gale Force
		[1311805] = {1311805, CL.you:format(mod:SpellName(1311805)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1311805, CL.you:format(mod:SpellName(1311805))}}, -- Tempest Winds
		[1288049] = {1288049}, -- Thunder and Lightning
		[1311804] = {1311804}, -- Overload
	})
end

--------------------------------------------------------------------------------
-- Midnight Auras
--

if mod:Retail() then -- Midnight+
	mod:SetAuraData({
		{1288457, duration = 4, note = CL.debuffDotAfterCastNote:format(mod:SpellName(1288457))}, -- Gust
		{1289059, duration = 4, note = CL.debuffTargetedNote:format(mod:SpellName(1289059))}, -- Gale Force
		{1288874, duration = 5, soundOnRemoved = "alarm", note = CL.debuffTargetedNote:format(mod:SpellName(1311805))}, -- Tempest Winds
		{1288885, duration = 4, mechanic = "silenced", note = CL.debuffFailureMoveFromCastNote:format(mod:SpellName(1311805))}, -- Tempest Winds
		{1288074, duration = 4.5, soundOnRemoved = "alarm", note = CL.debuffTargetedNote:format(mod:SpellName(1288049))}, -- Thunder and Lightning
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1310311, -- Storm Blessed
			-- Aspix
			1289059, -- Gale Force
			1311805, -- Tempest Winds
			-- Adderis
			1288049, -- Thunder and Lightning
			1311804, -- Overload
		}, {
			[1289059] = -18484, -- Aspix
			[1288049] = -18485, -- Adderis
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		stormBlessedCount = 1
		galeForceCount = 1
		thunderAndLightningCount = 1
		tempestWindsCount = 1
		overloadCount = 1
		count45 = 1
		count19 = 1
		adderisDead = false
		aspixDead = false
		boss2Seen = false
		bossDeathTime = 0
		activeBars = {}
		backupBars = {}
		if self:ShouldShowBars() then
			self:RegisterBossEvent("boss1", "BossEvent")
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

function mod:BossEvent() -- IEEU fired twice on pull (boss1 -> boss1 boss2), and once when boss2 dies (boss1)
	-- track the time when boss2 unengages
	if UnitExists("boss2") then
		boss2Seen = true
	elseif boss2Seen then
		bossDeathTime = GetTime()
	end
end

-- resyncs and Storm Blessed re-add active bars at their current remaining duration (~0.001 if already queued).
-- match those against tracked expTimes.
local function matchActiveBar(duration)
	local now = GetTime()
	local bestBar, bestDiff
	for _, barInfo in pairs(activeBars) do
		-- while paused, the remaining time is measured from the pause start, not now
		local remaining
		if barInfo.pauseStart then
			remaining = barInfo.expTime - barInfo.pauseStart
		else
			remaining = barInfo.expTime - now
		end
		if remaining < 0 then remaining = 0 end
		local diff = math.abs(duration - remaining)
		if diff <= 1.5 and (not bestDiff or diff < bestDiff) then
			bestBar, bestDiff = barInfo, diff
		end
	end
	return bestBar
end

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if self:IsWiping() or eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	-- increased precision to avoid false-positive matches as bars will be canceled and re-added with their ~previous times
	local duration = self:RoundNumber(eventInfo.duration, 3)
	-- a boss dying can re-add the surviving boss's abilities at arbitrary durations, which then get canceled anyway.
	-- for a 1s period after a boss dies, only 5/12/15/22 will be real timers.
	local bossJustDied = GetTime() - bossDeathTime <= 1
	if bossJustDied and (duration ~= 5 and duration ~= 12 and duration ~= 15 and duration ~= 22) then
		return
	end
	local barInfo
	-- initial: GF=5 TL=9 TW=29 OL=39 -> all 45
	-- re-sync: GF=1 TL=5 TW=25 OL=35 -> all 45
	-- Adderis dies: GF=5 TW=12 -> both 19
	-- Aspix dies: OL=15 TL=22 -> both 19
	-- during Storm Blessed (66%, 33%) bars pause. queued bars will be canceled and re-created with ~0.001s.
	-- TODO: counts increment a lot because bars are started and canceled in weird orders.
	if bossJustDied and (duration == 15 or duration == 22) and not adderisDead then -- Overload or Thunder and Lightning, after Aspix dies
		aspixDead = true
	elseif bossJustDied and (duration == 5 or duration == 12) and not aspixDead then -- Gale Force or Tempest Winds, after Adderis dies
		adderisDead = true
	end
	if eventInfo.duration == 1 then -- detect the Gale Force that's cast as part of the re-sync
		-- reset the shared ability counter during the re-sync in case anything weird happened during Storm Blessed
		count45 = 1
	end
	if (galeForceCount == 1 and duration == 5) or duration == 1 or (bossJustDied and duration == 5) then -- Gale Force (Aspix)
		barInfo = self:GaleForceTimeline(eventInfo, duration == 1)
	elseif duration == 9 or duration == 5 or (bossJustDied and duration == 22) then -- Thunder and Lightning (Adderis)
		barInfo = self:ThunderAndLightningTimeline(eventInfo, duration == 5)
	elseif duration == 29 or duration == 25 or (bossJustDied and duration == 12) then -- Tempest Winds (Aspix)
		barInfo = self:TempestWindsTimeline(eventInfo, duration == 25)
	elseif duration == 39 or duration == 35 or (bossJustDied and duration == 15) then -- Overload (Adderis)
		barInfo = self:OverloadTimeline(eventInfo, duration == 35)
	elseif duration == 45 then
		if count45 % 4 == 1 then -- Gale Force
			barInfo = self:GaleForceTimeline(eventInfo)
		elseif count45 % 4 == 2 then -- Thunder and Lightning
			barInfo = self:ThunderAndLightningTimeline(eventInfo)
		elseif count45 % 4 == 3 then -- Tempest Winds
			barInfo = self:TempestWindsTimeline(eventInfo)
		else -- Overload
			barInfo = self:OverloadTimeline(eventInfo)
		end
		count45 = count45 + 1
	elseif duration == 19 then
		if not aspixDead then -- Aspix alive
			if count19 % 2 == 1 then -- Gale Force
				barInfo = self:GaleForceTimeline(eventInfo)
			else -- Tempest Winds
				barInfo = self:TempestWindsTimeline(eventInfo)
			end
		elseif not adderisDead then -- Adderis alive
			if count19 % 2 == 1 then -- Overload
				barInfo = self:OverloadTimeline(eventInfo)
			else -- Thunder and Lightning
				barInfo = self:ThunderAndLightningTimeline(eventInfo)
			end
		end
		count19 = count19 + 1
	else -- re-sync matches against previous durations, this also handles queued bars during Storm Blessed
		-- these durations will match the existing bars and generally be in these ranges:
		-- - 0-1s Gale Force (0.001 can also be any spell queued during Storm Blessed)
		-- - 4-5s Thunder and Lightning
		-- - 22-25s Tempest Winds
		-- - 34-35s Overload
		local matchedBar = matchActiveBar(eventInfo.duration)
		if matchedBar then
			if matchedBar.key == 1289059 then
				barInfo = self:GaleForceTimeline(eventInfo, true)
			elseif matchedBar.key == 1288049 then
				barInfo = self:ThunderAndLightningTimeline(eventInfo, true)
			elseif matchedBar.key == 1311805 then
				barInfo = self:TempestWindsTimeline(eventInfo, true)
			elseif matchedBar.key == 1311804 then
				barInfo = self:OverloadTimeline(eventInfo, true)
			end
		end
	end
	if barInfo then
		local now = GetTime()
		barInfo.expTime = now + eventInfo.duration
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused
			barInfo.pauseStart = now
			self:PauseBar(barInfo.key, barInfo.msg)
		end
		activeBars[eventInfo.id] = barInfo
	else
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local barInfo = activeBars[eventID]
	if barInfo then
		local state = C_EncounterTimeline.GetEventState(eventID)
		if state == 0 then -- Active
			if barInfo.pauseStart then
				barInfo.expTime = barInfo.expTime - barInfo.pauseStart + GetTime()
				barInfo.pauseStart = nil
			end
			self:ResumeBar(barInfo.key, barInfo.msg)
		elseif state == 1 then -- Paused
			barInfo.pauseStart = GetTime()
			self:PauseBar(barInfo.key, barInfo.msg)
			-- bars pausing means Storm Blessed is being swapped
			self:StormBlessed()
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
	function mod:StormBlessed()
		if GetTime() - prev > 2 then -- all bars pause, so throttle here
			prev = GetTime()
			if stormBlessedCount % 2 == 1 then
				self:Message(1310311, "cyan", self:GetRename(1310311, 1)) -- Storm Blessed on Adderis
			else
				self:Message(1310311, "cyan", self:GetRename(1310311, 2)) -- Storm Blessed on Aspix
			end
			stormBlessedCount = stormBlessedCount + 1
			self:PlaySound(1310311, "long")
		end
	end
end

do
	local function IfOnMe(self)
		self:PlaySound(1289059, "alarm", nil, self:UnitName("player"))
	end
	function mod:GaleForceTimeline(eventInfo, resync) -- Gale Force
		local barText = CL.count:format(self:GetRename(1289059), galeForceCount)
		if resync then
			self:CDBar(1289059, {eventInfo.duration, 45}, barText, nil, eventInfo.id)
		else
			self:CDBar(1289059, eventInfo.duration, barText, nil, eventInfo.id)
		end
		galeForceCount = galeForceCount + 1
		return {
			msg = barText,
			key = 1289059,
			callback = function()
				-- in Mythic all 5 players get a PersonalMessage
				self:PersonalMessageFromBlizzMessage(1289059, 1, false, self:GetRename(1289059, 2), nil, nil, IfOnMe)
			end
		}
	end
end

function mod:ThunderAndLightningTimeline(eventInfo, resync) -- Thunder and Lightning
	local barText = CL.count:format(self:GetRename(1288049), thunderAndLightningCount)
	if resync then
		self:CDBar(1288049, {eventInfo.duration, 45}, barText, nil, eventInfo.id)
	else
		self:CDBar(1288049, eventInfo.duration, barText, nil, eventInfo.id)
	end
	thunderAndLightningCount = thunderAndLightningCount + 1
	return {
		msg = barText,
		key = 1288049,
		callback = function()
			self:TargetMessageFromBlizzMessage(1288049, 1, "orange", false)
			self:PlaySound(1288049, "info")
		end
	}
end

do
	local function IfOnMe(self)
		self:PlaySound(1311805, "warning", nil, self:UnitName("player"))
	end
	function mod:TempestWindsTimeline(eventInfo, resync) -- Tempest Winds
		local barText = CL.count:format(self:GetRename(1311805), tempestWindsCount)
		if resync then
			self:CDBar(1311805, {eventInfo.duration, 45}, barText, nil, eventInfo.id)
		else
			self:CDBar(1311805, eventInfo.duration, barText, nil, eventInfo.id)
		end
		tempestWindsCount = tempestWindsCount + 1
		return {
			msg = barText,
			key = 1311805,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1311805, 4, false, self:GetRename(1311805, 2), nil, nil, IfOnMe)
				self:Message(1311805, "yellow", barText)
			end
		}
	end
end

function mod:OverloadTimeline(eventInfo, resync) -- Overload
	local barText = CL.count:format(self:GetRename(1311804), overloadCount)
	if resync then
		self:CDBar(1311804, {eventInfo.duration, 45}, barText, nil, eventInfo.id)
	else
		self:CDBar(1311804, eventInfo.duration, barText, nil, eventInfo.id)
	end
	overloadCount = overloadCount + 1
	return {
		msg = barText,
		key = 1311804,
		callback = function()
			self:Message(1311804, "purple", barText)
			self:PlaySound(1311804, "alert")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevDash = 0
	local prevShieldGUID = nil
	function mod:UNIT_POWER_FREQUENT(event, unit)
		local guid = self:UnitGUID(unit)
		local t = GetTime()
		-- Adderis gets 100 energy when he dies
		if t-prevDash > 2 and self:MobId(guid) == 133379 and not UnitIsDead(unit) then -- Adderis
			if UnitPower(unit) == 100 then
				prevDash = t
				self:Message(263424, "orange") -- Arc Dash
				self:PlaySound(263424, "alert") -- Arc Dash
			end
		end
		if guid ~= prevShieldGUID and UnitPower(unit) == 0 then
			prevShieldGUID = guid
			self:Bar(263246, 4) -- Lightning Shield
		end
	end
end

function mod:LightningShield(args)
	self:Message(args.spellId, "cyan", CL.other:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
	local otherBoss = self:UnitGUID("boss1") == args.destGUID and "boss2" or "boss1"
	self:PrimaryIcon(args.spellId, otherBoss)
	if self:MobId(args.destGUID) == 133379 then -- Adderis
		self:Bar(263424, 20) -- Arc Dash
	else -- Aspix
		if cycloneStrikeCount ~= 0 then -- Timer is slightly different from the first
			self:Bar(263309, 6.5) -- Cyclone Strike
		end
		self:Bar(263257, 20) -- Static Shock
	end
end

function mod:Conduction(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId, nil, nil, "Conduction")
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:ConductionRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(263309, nil, nil, "Cyclone Strike") -- Cyclone Strike
			self:Flash(263309) -- Cyclone Strike
		end
	end

	function mod:CycloneStrike(args)
		cycloneStrikeCount = cycloneStrikeCount + 1
		if cycloneStrikeCount % 2 == 1 then
			self:Bar(args.spellId, 13.5)
		end
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CastBar(args.spellId, 2.5)
	end
end

function mod:StaticShock(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 2)
end

function mod:BossDeath(args)
	self:StopBar(263424) -- Arc Dash
	self:StopBar(263257) -- Static Shock
end
