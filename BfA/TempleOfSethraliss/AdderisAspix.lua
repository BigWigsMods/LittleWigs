--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Adderis and Aspix", 1877, 2142)
if not mod then return end
mod:RegisterEnableMob(133379, 133944) -- Adderis, Aspix
mod:SetEncounterID(2124)
if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
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

local galeForceCount = 1
local thunderAndLightningCount = 1
local tempestWindsCount = 1
local overloadCount = 1
local count55 = 1
local adderisDead = false
local aspixDead = false
local aspixSpells = { [1288864] = true, [1289059] = true } -- Tempest Winds, Gale Force
local adderisSpells = { [1288049] = true, [1288428] = true } -- Thunder and Lightning, Overload
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[1289059] = {1289059, CL.you:format(mod:SpellName(1289059)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1289059, CL.you:format(mod:SpellName(1289059))}}, -- Gale Force
		[1288864] = {1288864, CL.you:format(mod:SpellName(1288864)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1288864, CL.you:format(mod:SpellName(1288864))}}, -- Tempest Winds
		[1288049] = {1288049}, -- Thunder and Lightning
		[1288428] = {1288428}, -- Overload
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			1289059, -- Gale Force
			1288864, -- Tempest Winds
			1288049, -- Thunder and Lightning
			1288428, -- Overload
		}, {
			[1289059] = -18484, -- Aspix
			[1288049] = -18485, -- Adderis
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		galeForceCount = 1
		thunderAndLightningCount = 1
		tempestWindsCount = 1
		overloadCount = 1
		count55 = 1
		adderisDead = false
		aspixDead = false
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 8 or (duration == 55 and not aspixDead and (adderisDead or count55 % 2 == 1)) then -- Gale Force
		barInfo = self:GaleForceTimeline(eventInfo)
	elseif duration == 22 or (duration == 55 and not adderisDead and (aspixDead or count55 % 2 == 0)) then -- Thunder and Lightning
		barInfo = self:ThunderAndLightningTimeline(eventInfo)
	elseif duration == 33 or duration == 57 then -- Tempest Winds
		barInfo = self:TempestWindsTimeline(eventInfo)
	elseif duration == 48 or duration == 59 then -- Overload
		barInfo = self:OverloadTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 55 then
		count55 = count55 + 1
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
			if adderisSpells[barInfo.key] then
				adderisDead = true
			end
			if aspixSpells[barInfo.key] then
				aspixDead = true
			end
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

function mod:GaleForceTimeline(eventInfo) -- Gale Force
	local barText = CL.count:format(self:GetRename(1289059), galeForceCount)
	self:CDBar(1289059, eventInfo.duration, barText, nil, eventInfo.id)
	galeForceCount = galeForceCount + 1
	return {
		msg = barText,
		key = 1289059,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1289059, 1, false, self:GetRename(1289059, 2))
			self:Message(1289059, "red", barText)
			self:PlaySound(1289059, "alarm")
		end
	}
end

function mod:ThunderAndLightningTimeline(eventInfo) -- Thunder and Lightning
	local barText = CL.count:format(self:GetRename(1288049), thunderAndLightningCount)
	self:CDBar(1288049, eventInfo.duration, barText, nil, eventInfo.id)
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
		self:PlaySound(1288864, "warning", nil, self:UnitName("player"))
	end
	function mod:TempestWindsTimeline(eventInfo) -- Tempest Winds
		local barText = CL.count:format(self:GetRename(1288864), tempestWindsCount)
		self:CDBar(1288864, eventInfo.duration, barText, nil, eventInfo.id)
		tempestWindsCount = tempestWindsCount + 1
		return {
			msg = barText,
			key = 1288864,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1288864, 1, false, self:GetRename(1288864, 2), nil, nil, IfOnMe)
				self:Message(1288864, "yellow", barText)
			end
		}
	end
end

function mod:OverloadTimeline(eventInfo) -- Overload
	local barText = CL.count:format(self:GetRename(1288428), overloadCount)
	self:CDBar(1288428, eventInfo.duration, barText, nil, eventInfo.id)
	overloadCount = overloadCount + 1
	return {
		msg = barText,
		key = 1288428,
		callback = function()
			self:Message(1288428, "purple", barText)
			self:PlaySound(1288428, "alert")
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
