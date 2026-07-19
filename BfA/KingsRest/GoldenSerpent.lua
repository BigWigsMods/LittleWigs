--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Golden Serpent", 1762, 2165)
if not mod then return end
mod:RegisterEnableMob(135322) -- The Golden Serpent
mod:SetEncounterID(2139)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{265773, "SAY", "SAY_COUNTDOWN"}, -- Spit Gold
		265923, -- Lucre's Call
		265781, -- Serpentine Gust
		{265910, "TANK_HEALER"}, -- Tail Thrash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpitGold", 265773)
	self:Log("SPELL_AURA_APPLIED", "SpitGoldApplied", 265773)
	self:Log("SPELL_AURA_REMOVED", "SpitGoldRemoved", 265773)
	self:Log("SPELL_CAST_START", "LucresCall", 265923)
	self:Log("SPELL_CAST_START", "SerpentineGust", 265781)
	self:Log("SPELL_CAST_START", "TailThrash", 265910)
end

function mod:OnEngage()
	self:CDBar(265773, 9) -- Spit Gold
	self:CDBar(265923, 40) -- Lucre's Call
	self:CDBar(265781, 12.5) -- Serpentine Gust
	self:CDBar(265910, 15.5) -- Tail Thrash
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local spitGoldCount = 1
local tailThrashCount = 1
local serpentineGustCount = 1
local lucresCallCount = 1
local count25 = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	mod:SetRenames({
		[265773] = {265773, CL.you:format(mod:SpellName(265773)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {265773, CL.you:format(mod:SpellName(265773))}}, -- Spit Gold
		[265910] = {265910}, -- Tail Thrash
		[265781] = {265781}, -- Serpentine Gust
		[265923] = {265923}, -- Lucre's Call
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if BigWigsLoader.isNext then -- Midnight+ XXX swap to mod:Retail() in 12.1
	function mod:GetOptions()
		return {
			265773, -- Spit Gold
			265910, -- Tail Thrash
			265781, -- Serpentine Gust
			265923, -- Lucre's Call
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		spitGoldCount = 1
		tailThrashCount = 1
		serpentineGustCount = 1
		lucresCallCount = 1
		count25 = 1
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
	if duration == 5 or (duration == 25 and count25 % 2 == 1) then -- Spit Gold
		barInfo = self:SpitGoldTimeline(eventInfo)
	elseif duration == 8 or (duration == 25 and count25 % 2 == 0) then -- Tail Thrash
		barInfo = self:TailThrashTimeline(eventInfo)
	elseif duration == 14 or duration == 28 then -- Serpentine Gust
		barInfo = self:SerpentineGustTimeline(eventInfo)
	elseif duration == 54 then -- Lucre's Call
		barInfo = self:LucresCallTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
		backupBars[eventInfo.id] = true
		self:SendMessage("BigWigs_StartBar", nil, nil, ("[B] %s"):format(eventInfo.spellName), eventInfo.duration, eventInfo.iconFileID, eventInfo.maxQueueDuration, nil, eventInfo.id, eventInfo.id)
		local state = C_EncounterTimeline.GetEventState(eventInfo.id)
		if state == 1 then -- Enum.EncounterTimelineEventState.Paused = 1
			self:SendMessage("BigWigs_PauseBar", nil, nil, eventInfo.id)
		end
	end
	if duration == 25 then
		count25 = count25 + 1
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

do
	local function IfOnMe(self)
		self:PlaySound(265773, "warning", nil, self:UnitName("player"))
	end
	function mod:SpitGoldTimeline(eventInfo) -- Spit Gold
		local barText = CL.count:format(self:GetRename(265773), spitGoldCount)
		self:CDBar(265773, eventInfo.duration, barText, nil, eventInfo.id)
		spitGoldCount = spitGoldCount + 1
		return {
			msg = barText,
			key = 265773,
			callback = function()
				self:PersonalMessageFromBlizzMessage(265773, 1, false, self:GetRename(265773, 2), nil, nil, IfOnMe) -- TODO confirm
				self:Message(265773, "orange", barText)
			end
		}
	end
end

function mod:TailThrashTimeline(eventInfo) -- Tail Thrash
	local barText = CL.count:format(self:GetRename(265910), tailThrashCount)
	self:CDBar(265910, eventInfo.duration, barText, nil, eventInfo.id)
	tailThrashCount = tailThrashCount + 1
	return {
		msg = barText,
		key = 265910,
		callback = function()
			self:Message(265910, "purple", barText)
			self:PlaySound(265910, "alert")
		end
	}
end

function mod:SerpentineGustTimeline(eventInfo) -- Serpentine Gust
	local barText = CL.count:format(self:GetRename(265781), serpentineGustCount)
	self:CDBar(265781, eventInfo.duration, barText, nil, eventInfo.id)
	serpentineGustCount = serpentineGustCount + 1
	return {
		msg = barText,
		key = 265781,
		callback = function()
			self:Message(265781, "red", barText)
			self:PlaySound(265781, "alarm")
		end
	}
end

function mod:LucresCallTimeline(eventInfo) -- Lucre's Call
	local barText = CL.count:format(self:GetRename(265923), lucresCallCount)
	self:CDBar(265923, eventInfo.duration, barText, nil, eventInfo.id)
	lucresCallCount = lucresCallCount + 1
	return {
		msg = barText,
		key = 265923,
		callback = function()
			self:Message(265923, "cyan", barText)
			self:PlaySound(265923, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(265773, "orange", name)
			self:PlaySound(265773, "warning", nil, name)
		end
	end

	function mod:SpitGold(args)
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
		self:CDBar(args.spellId, 11)
	end
end

function mod:SpitGoldApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Spit Gold")
		self:SayCountdown(args.spellId, 9)
	end
end

function mod:SpitGoldRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:LucresCall(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 41.5)
end

function mod:SerpentineGust(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.5)
end

function mod:TailThrash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17)
end
