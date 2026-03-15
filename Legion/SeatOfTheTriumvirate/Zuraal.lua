-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuraal", 1753, 1979)
if not mod then return end
mod:RegisterEnableMob(122313) -- Zuraal the Ascended
mod:SetEncounterID(2065)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{244588, sound = "underyou"}, -- Void Sludge
	{244599, sound = "warning"}, -- Dark Expulsion
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		246134, -- Null Palm
		244579, -- Decimate
		244602, -- Coalesced Void
		244433, -- Umbra Shift
		{244653, "SAY"}, -- Fixate
		244621, -- Void Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NullPalm", 246134)
	self:Log("SPELL_CAST_START", "Decimate", 244579)
	self:Log("SPELL_CAST_SUCCESS", "CoalescedVoid", 246139)
	self:Log("SPELL_DAMAGE", "UmbraShift", 244433) -- No debuff or targeted events
	self:Log("SPELL_AURA_APPLIED", "Fixate", 244653)
	self:Log("SPELL_AURA_APPLIED", "VoidTear", 244621)
	self:Log("SPELL_AURA_REMOVED", "VoidTearRemoved", 244621)
end

function mod:OnEngage()
	self:CDBar(246134, 10.5) -- Null Palm
	self:CDBar(244579, 18) -- Decimate
	self:CDBar(244602, 20) -- Coalesced Void
	self:CDBar(244433, 41) -- Umbra Shift
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local voidSlashCount = 1
local decimateCount = 1
local nullPalmCount = 1
local oozingSlamCount = 1
local crashingVoidCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1263440, "TANK_HEALER"}, -- Void Slash
			1263282, -- Decimate
			1268916, -- Null Palm
			1263399, -- Oozing Slam
			1263297, -- Crashing Void
			{244588, "PRIVATE"}, -- Void Sludge
			--{244599, "PRIVATE"}, -- Dark Expulsion
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		voidSlashCount = 1
		decimateCount = 1
		nullPalmCount = 1
		oozingSlamCount = 1
		crashingVoidCount = 1
		activeBars = {}
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		end
	end

	function mod:OnWin()
		activeBars = {}
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = eventInfo.duration
	duration = math.floor(duration + 0.5)
	local barInfo
	if duration > 60 then return end -- always canceled
	if duration == 4 or duration == 40 then -- Void Slash
		barInfo = self:VoidSlashTimeline(eventInfo)
	elseif duration == 7 or duration == 28 then -- Decimate
		barInfo = self:DecimateTimeline(eventInfo)
	elseif duration == 16 then -- Null Palm
		barInfo = self:NullPalmTimeline(eventInfo)
	elseif duration == 22 then -- Oozing Slam
		barInfo = self:OozingSlamTimeline(eventInfo)
	elseif duration == 50 then -- Crashing Void
		barInfo = self:CrashingVoidTimeline(eventInfo)
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
			if not self:IsWiping() and barInfo.cancelCallback then
				barInfo.cancelCallback()
			end
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
-- Timeline Ability Handlers
--

function mod:VoidSlashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263440), voidSlashCount)
	self:CDBar(1263440, eventInfo.duration, barText, nil, eventInfo.id)
	voidSlashCount = voidSlashCount + 1
	return {
		msg = barText,
		key = 1263440,
		callback = function()
			self:Message(1263440, "purple", barText)
			self:PlaySound(1263440, "alert")
		end
	}
end

function mod:DecimateTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263282), decimateCount)
	self:CDBar(1263282, eventInfo.duration, barText, nil, eventInfo.id)
	decimateCount = decimateCount + 1
	return {
		msg = barText,
		key = 1263282,
		callback = function()
			self:Message(1263282, "red", barText)
			self:PlaySound(1263282, "alarm")
		end
	}
end

function mod:NullPalmTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1268916), nullPalmCount)
	self:CDBar(1268916, eventInfo.duration, barText, nil, eventInfo.id)
	nullPalmCount = nullPalmCount + 1
	return {
		msg = barText,
		key = 1268916,
		callback = function()
			self:Message(1268916, "orange", barText)
			self:PlaySound(1268916, "alarm")
		end
	}
end

function mod:OozingSlamTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263399), oozingSlamCount)
	self:CDBar(1263399, eventInfo.duration, barText, nil, eventInfo.id)
	oozingSlamCount = oozingSlamCount + 1
	return {
		msg = barText,
		key = 1263399,
		callback = function()
			self:Message(1263399, "yellow", barText)
			self:PlaySound(1263399, "info")
		end
	}
end

function mod:CrashingVoidTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263297), crashingVoidCount)
	self:CDBar(1263297, eventInfo.duration, barText, nil, eventInfo.id)
	crashingVoidCount = crashingVoidCount + 1
	return {
		msg = barText,
		key = 1263297,
		cancelCallback = function()
			self:Message(1263297, "yellow", barText)
			self:PlaySound(1263297, "alert")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullPalm(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 55)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Decimate(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 12.5)
	self:PlaySound(args.spellId, "warning")
end

function mod:CoalescedVoid()
	self:Message(244602, "yellow")
	self:CDBar(244602, 55)
	self:PlaySound(244602, "alert")
end

function mod:UmbraShift(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 55)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Fixate(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Fixate")
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:VoidTear(args)
	self:StopBar(246134) -- Null Palm
	self:StopBar(244579) -- Decimate
	self:StopBar(244602) -- Coalesced Void
	self:StopBar(244433) -- Umbra Shift
	self:Message(args.spellId, "green", args.spellName)
	self:Bar(args.spellId, 20)
	self:PlaySound(args.spellId, "long")
end

function mod:VoidTearRemoved(args)
	self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
	self:PlaySound(args.spellId, "info")
end
