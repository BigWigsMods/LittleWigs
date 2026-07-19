--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dazar, The First King", 1762, 2172)
if not mod then return end
mod:RegisterEnableMob(136160, 136984, 136976) -- Dazar, Reban, T'zala
mod:SetEncounterID(2143)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local nextHPWarning = 85
local mobCollector = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spears_active = "Spear Launchers Active"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{268586, "TANK_HEALER"}, -- Blade Combo
		{268932, "SAY", "ICON"}, -- Quaking Leap
		268403, -- Gale Slash
		269231, -- Hunting Leap
		269369, -- Deathly Roar
	}, {
		[268586] = "general",
		[269231] = -18251, -- Reban
		[269369] = -18254, -- T'zala
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("Deaths", 136984, 136976) -- Reban, T'zala

	self:Log("SPELL_CAST_START", "BladeCombo", 268586)
	self:Log("SPELL_CAST_START", "QuakingLeap", 268932)
	self:Log("SPELL_CAST_START", "GaleSlash", 268403)
	self:Log("SPELL_CAST_SUCCESS", "QuakingLeapLanding", 268936)
	self:Log("SPELL_CAST_SUCCESS", "HuntingLeap", 269231)
	self:Log("SPELL_DAMAGE", "HuntingLeapDamage", 269230)
	self:Log("SPELL_MISSED", "HuntingLeapDamage", 269230)
	self:Log("SPELL_CAST_START", "DeathlyRoar", 269369)
end

function mod:OnEngage()
	nextHPWarning = 85 -- 80%, 60% and 40%
	mobCollector = {}
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()

	self:CDBar(268586, 18.2) -- Blade Combo
	self:CDBar(268932, 12.1) -- Quaking Leap
	self:CDBar(268932, 12.1) -- Gale Slash
end

function mod:VerifyEnable(unit)
	return self:GetHealth(unit) > 10
end

function mod:OnBossDisable()
	mobCollector = {}
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local huntingLeapCount = 1
local deathlyRoarCount = 1
local aerialSmashCount = 1
local bladeComboCount = 1
local gildedDestructionCount = 1
local quakingLeapCount = 1
local savageMaulCount = 1
local count10 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[269230] = {269230}, -- Hunting Leap
		[269369] = {269369}, -- Deathly Roar
		[1303115] = {1303115, CL.you:format(mod:SpellName(1303115)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1303115, CL.you:format(mod:SpellName(1303115))}}, -- Aerial Smash
		[268586] = {268586}, -- Blade Combo
		[1303267] = {1303267}, -- Gilded Destruction
		[1303326] = {1303326, CL.you:format(mod:SpellName(1303326)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1303326, CL.you:format(mod:SpellName(1303326))}}, -- Quaking Leap
		[1303481] = {1303481}, -- Savage Maul
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			269230, -- Hunting Leap
			269369, -- Deathly Roar
			1303115, -- Aerial Smash
			268586, -- Blade Combo
			1303267, -- Gilded Destruction
			1303326, -- Quaking Leap
			1303481, -- Savage Maul
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		huntingLeapCount = 1
		deathlyRoarCount = 1
		aerialSmashCount = 1
		bladeComboCount = 1
		gildedDestructionCount = 1
		quakingLeapCount = 1
		savageMaulCount = 1
		count10 = 1
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
	-- Stage 1: Hunting Leap 8->10, Deathly Roar 14->10, Aerial Smash 15, Blade Combo 23, Gilded Destruction 30
	-- Stage 2: Quaking Leap 9, Gilded Destruction 24, Savage Maul 36, Blade Combo 38
	if duration == 8 or (duration == 10 and count10 % 2 == 1) then -- Hunting Leap
		barInfo = self:HuntingLeapTimeline(eventInfo)
	elseif duration == 14 or (duration == 10 and count10 % 2 == 0) then -- Deathly Roar
		barInfo = self:DeathlyRoarTimeline(eventInfo)
	elseif duration == 15 then -- Aerial Smash
		barInfo = self:AerialSmashTimeline(eventInfo)
	elseif duration == 23 or duration == 38 then -- Blade Combo
		barInfo = self:BladeComboTimeline(eventInfo)
	elseif (self:GetStage() == 1 and not self:IsWiping() and duration == 30) or duration == 24 then -- Gilded Destruction
		barInfo = self:GildedDestructionTimeline(eventInfo)
	elseif duration == 9 then -- Quaking Leap
		barInfo = self:QuakingLeapTimeline(eventInfo)
	elseif duration == 36 then -- Savage Maul
		barInfo = self:SavageMaulTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 10 then
		count10 = count10 + 1
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
			if barInfo.cancelCallback then
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

function mod:HuntingLeapTimeline(eventInfo) -- Hunting Leap
	local barText = CL.count:format(self:GetRename(269230), huntingLeapCount)
	self:CDBar(269230, eventInfo.duration, barText, nil, eventInfo.id)
	huntingLeapCount = huntingLeapCount + 1
	local timer = self:ScheduleTimer(function()
		self:StopBar(barText)
		self:Message(269230, "orange", barText)
		self:PlaySound(269230, "alarm")
	end, eventInfo.duration)
	return {
		msg = barText,
		key = 269230,
		callback = function()
			self:Error("Hunting Leap now has a callback")
		end,
		cancelCallback = function()
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
		end
	}
end

function mod:DeathlyRoarTimeline(eventInfo) -- Deathly Roar
	local barText = CL.count:format(self:GetRename(269369), deathlyRoarCount)
	self:CDBar(269369, eventInfo.duration, barText, nil, eventInfo.id)
	deathlyRoarCount = deathlyRoarCount + 1
	return {
		msg = barText,
		key = 269369,
		callback = function()
			self:Message(269369, "red", barText)
			self:PlaySound(269369, "warning")
		end,
		cancelCallback = function()
			self:SetStage(2) -- Reban died
		end
	}
end

function mod:AerialSmashTimeline(eventInfo) -- Aerial Smash
	local barText = CL.count:format(self:GetRename(1303115), aerialSmashCount)
	self:CDBar(1303115, eventInfo.duration, barText, nil, eventInfo.id)
	aerialSmashCount = aerialSmashCount + 1
	local timer = self:ScheduleTimer(function()
		self:StopBar(barText)
		self:PersonalMessageFromBlizzMessage(1303115, 1, false, self:GetRename(1303115, 2))
		self:Message(1303115, "yellow", barText)
		self:PlaySound(1303115, "info")
	end, eventInfo.duration)
	return {
		msg = barText,
		key = 1303115,
		callback = function()
			self:Error("Aerial Smash now has a callback")
		end,
		cancelCallback = function()
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
		end
	}
end

function mod:BladeComboTimeline(eventInfo) -- Blade Combo
	local barText = CL.count:format(self:GetRename(268586), bladeComboCount)
	self:CDBar(268586, eventInfo.duration, barText, nil, eventInfo.id)
	bladeComboCount = bladeComboCount + 1
	return {
		msg = barText,
		key = 268586,
		callback = function()
			self:Message(268586, "purple", barText)
			self:PlaySound(268586, "alert")
		end
	}
end

function mod:GildedDestructionTimeline(eventInfo) -- Gilded Destruction
	local barText = CL.count:format(self:GetRename(1303267), gildedDestructionCount)
	self:CDBar(1303267, eventInfo.duration, barText, nil, eventInfo.id)
	gildedDestructionCount = gildedDestructionCount + 1
	return {
		msg = barText,
		key = 1303267,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1303267, "red", barText)
			self:PlaySound(1303267, "long")
		end
	}
end

function mod:QuakingLeapTimeline(eventInfo) -- Quaking Leap
	local barText = CL.count:format(self:GetRename(1303326), quakingLeapCount)
	self:CDBar(1303326, eventInfo.duration, barText, nil, eventInfo.id)
	quakingLeapCount = quakingLeapCount + 1
	local timer = self:ScheduleTimer(function()
		self:StopBar(barText)
		self:PersonalMessageFromBlizzMessage(1303326, 1, false, self:GetRename(1303326, 2))
		self:Message(1303326, "orange", barText)
		self:PlaySound(1303326, "long")
	end, eventInfo.duration)
	return {
		msg = barText,
		key = 1303326,
		callback = function()
			self:Error("Quaking Leap now has a callback")
		end,
		cancelCallback = function()
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
		end
	}
end

function mod:SavageMaulTimeline(eventInfo) -- Savage Maul
	local barText = CL.count:format(self:GetRename(1303481), savageMaulCount)
	self:CDBar(1303481, eventInfo.duration, barText, nil, eventInfo.id)
	savageMaulCount = savageMaulCount + 1
	return {
		msg = barText,
		key = 1303481,
		callback = function()
			self:Message(1303481, "purple", barText)
			self:PlaySound(1303481, "alarm")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 3 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid and not mobCollector[guid] then
			mobCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 136984 then -- Reban
				self:Message("stages", "yellow", CL.spawned:format(self:SpellName(-18251)), false)
				self:CDBar(269231, 5) -- Hunting Leap
			elseif mobId == 136976 then -- T'zala
				self:Message("stages", "yellow", CL.spawned:format(self:SpellName(-18254)), false)
				self:CDBar(269369, 8.5) -- Deathly Roar
			end
		end
	end
end

function mod:Deaths(args)
	self:SetStage(self:GetStage() + 1)
	if args.mobId == 136984 then -- Reban
		self:StopBar(269231) -- Hunting Leap
	else -- T'zala
		self:StopBar(269369) -- Deathly Roar
	end
end

do
	local mechanics = {
		-18251, -- Reban
		-18254, -- T'zala
		268796, -- Impaling Spear
	}
	function mod:UNIT_HEALTH(event, unit)
		local hp = self:GetHealth(unit)
		if hp < nextHPWarning then
			local index = 3 - (nextHPWarning - 45) / 20 -- 85 -> 1, 65 -> 2, 45 -> 3
			nextHPWarning = nextHPWarning - 20
			self:Message("stages", "cyan", CL.soon:format(self:SpellName(mechanics[index])), false)
			self:PlaySound("stages", "info")

			if index >= #mechanics then
				self:UnregisterUnitEvent(event, unit)
			end
		end
	end
end

function mod:BladeCombo(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 17)
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(268932, "orange", player)
		self:PlaySound(268932, "long", nil, player)
		self:PrimaryIcon(268932, player)
		if self:Me(guid) then
			self:Say(268932, nil, nil, "Quaking Leap")
		end
	end

	function mod:QuakingLeap(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20)
	end

	function mod:QuakingLeapLanding()
		self:PrimaryIcon(268932)
	end
end

function mod:GaleSlash(args)
	self:CDBar(args.spellId, 14.5)
end

function mod:HuntingLeap(args)
	self:CDBar(args.spellId, 12.2)
end

do
	local prev = 0
	function mod:HuntingLeapDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(269231, "near")
				self:PlaySound(269231, "alert")
			end
		end
	end
end

function mod:DeathlyRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "warning")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if not self:IsSecret(spellId) and spellId == 269377 then -- Spike Pattern Controller
		self:Message("stages", "yellow", L.spears_active, 268796) -- Impaling Spear
		self:UnregisterUnitEvent(event, unit)
	end
end
