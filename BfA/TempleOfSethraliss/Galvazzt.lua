--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", 1877, 2144)
if not mod then return end
mod:RegisterEnableMob(133389)
mod:SetEncounterID(2126)
if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRespawnTime(30)
else
	mod:SetRespawnTime(25)
end

--------------------------------------------------------------------------------
-- Locals
--

local galvanizeList = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{266923, "INFOBOX"}, -- Galvanize
		{266512, "CASTBAR"}, -- Consume Charge
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "Galvanize", 266923)
	self:Log("SPELL_AURA_APPLIED_DOSE", "GalvanizeStack", 266923)
	self:Log("SPELL_AURA_REMOVED", "GalvanizeRemoved", 266923)
	self:Log("SPELL_AURA_APPLIED", "GalvanizeOnBoss", 265986) -- Spell aura on boss is called 'Arc'
	self:Log("SPELL_CAST_START", "ConsumeCharge", 266512)
end

function mod:OnEngage()
	galvanizeList = {}
	self:OpenInfo(266923, self:SpellName(266923)) -- Galvanize
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local lightningSpireCount = 1
local inductionCount = 1
local count26 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[1291618] = {1291618}, -- Lightning Spire
		[1309525] = {1309525}, -- Induction
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			1291618, -- Lightning Spire
			1309525, -- Induction
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		lightningSpireCount = 1
		inductionCount = 1
		count26 = 1
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
	if duration == 6 or (duration == 26 and count26 % 2 == 1) then -- Lightning Spire
		barInfo = self:LightningSpireTimeline(eventInfo)
	elseif duration == 24 or (duration == 26 and count26 % 2 == 0) then -- Induction
		barInfo = self:InductionTimeline(eventInfo)
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
	if duration == 26 then
		count26 = count26 + 1
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

function mod:LightningSpireTimeline(eventInfo) -- Lightning Spire
	local barText = CL.count:format(self:GetRename(1291618), lightningSpireCount)
	self:CDBar(1291618, eventInfo.duration, barText, nil, eventInfo.id)
	lightningSpireCount = lightningSpireCount + 1
	return {
		msg = barText,
		key = 1291618,
		callback = function()
			self:StopBlizzMessages(1) -- TODO confirm (emote?)
			self:Message(1291618, "yellow", barText)
			self:PlaySound(1291618, "info")
		end
	}
end

function mod:InductionTimeline(eventInfo) -- Induction
	local barText = CL.count:format(self:GetRename(1309525), inductionCount)
	self:CDBar(1309525, eventInfo.duration, barText, nil, eventInfo.id)
	inductionCount = inductionCount + 1
	return {
		msg = barText,
		key = 1309525,
		callback = function()
			self:Message(1309525, "orange", barText)
			self:PlaySound(1309525, "alarm")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:UNIT_POWER_FREQUENT(_, unit, powerType)
		if powerType == "ALTERNATE" then
			local t = GetTime()
			if t-prev > (self:Normal() and 3 or 0.5) then
				prev = t
				local power = UnitPower(unit, 10) -- Alternate power, max 100
				if not self:IsSecret(power) and power > 0 then
					self:Message(266512, "orange", CL.percent:format(power, self:SpellName(266512))) -- Consume Charge
					self:PlaySound(266512, "alarm") -- Consume Charge
				end
			end
		end
	end
end

function mod:Galvanize(args)
	galvanizeList[args.destName] = 1
	self:SetInfoByTable(args.spellId, galvanizeList)
end

function mod:GalvanizeStack(args)
	galvanizeList[args.destName] = args.amount
	self:SetInfoByTable(args.spellId, galvanizeList)
	if self:Me(args.destGUID) then
		if args.amount % 3 == 0 then
			self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
			if args.amount > 6 then
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

function mod:GalvanizeRemoved(args)
	galvanizeList[args.destName] = 0
	self:SetInfoByTable(args.spellId, galvanizeList)
end

function mod:GalvanizeOnBoss(args)
	self:Message(266923, "orange", -18921) -- Galvanize, Energy Core
	self:PlaySound(266923, "alert")
end

function mod:ConsumeCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 3)
end
