--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ick & Krick", 658, 609)
if not mod then return end
mod:RegisterEnableMob(36476, 36477)
mod:SetEncounterID(mod:Classic() and 835 or 2001)
mod:SetRespawnTime(30)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{1264186, sound = "alert"}, -- Shadowbind
		{1264246, sound = "none"}, -- Shade Shift
		{1264299, sound = "underyou"}, -- Blight
		{1264453, sound = "warning"}, -- Lumbering Fixation
	})
end

--------------------------------------------------------------------------------
-- Locals
--

local barrage = nil
local pursuitWarned = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		70274, -- Toxic Waste
		68989, -- Poison Nova
		69263, -- Explosive Barrage
		68987, -- Pursuit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 69263)
	self:Log("SPELL_AURA_REMOVED", "BarrageEnd", 69263)
	self:Log("SPELL_AURA_APPLIED", "ToxicWaste", 69024, 70274)
	self:Log("SPELL_CAST_START", "PoisonNova", 68989)

	self:RegisterEvent("UNIT_AURA")
end

function mod:OnEngage()
	barrage = nil
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local blightSmashCount = 1
local plagueExpulsionCount = 1
local shadeShiftCount = 1
local getEmIckCount = 1
local count19 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1264287, -- Blight Smash
			1264336, -- Plague Expulsion
			1264027, -- Shade Shift
			1264363, -- Get 'Em, Ick!
			{1264186, "PRIVATE"}, -- Shadowbind
			{1264246, "PRIVATE"}, -- Shade Shift
			{1264299, "PRIVATE"}, -- Blight
			{1264453, "PRIVATE"}, -- Lumbering Fixation
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		blightSmashCount = 1
		plagueExpulsionCount = 1
		shadeShiftCount = 1
		getEmIckCount = 1
		count19 = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 2)
	local barInfo
	if duration == 11 or (duration == 19 and count19 % 2 == 1) then -- Blight Smash
		barInfo = self:BlightSmashTimeline(eventInfo)
	elseif (duration == 19 and count19 % 2 == 0) or duration == 21 then -- Plague Expulsion
		barInfo = self:PlagueExpulsionTimeline(eventInfo)
	elseif duration == 28.75 then -- Shade Shift
		barInfo = self:ShadeShiftTimeline(eventInfo)
	elseif duration == 50 then -- Get 'Em, Ick!
		barInfo = self:GetEmIckTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 19 then
		count19 = count19 + 1
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

function mod:BlightSmashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264287), blightSmashCount)
	self:CDBar(1264287, eventInfo.duration, barText, nil, eventInfo.id)
	blightSmashCount = blightSmashCount + 1
	return {
		msg = barText,
		key = 1264287,
		callback = function()
			self:Message(1264287, "purple", barText)
			if self:Tank() then
				self:PlaySound(1264287, "alarm")
			else
				self:PlaySound(1264287, "info")
			end
		end
	}
end

function mod:PlagueExpulsionTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264336), plagueExpulsionCount)
	self:CDBar(1264336, eventInfo.duration, barText, nil, eventInfo.id)
	plagueExpulsionCount = plagueExpulsionCount + 1
	return {
		msg = barText,
		key = 1264336,
		callback = function()
			self:Message(1264336, "orange", barText)
			self:PlaySound(1264336, "alarm")
		end
	}
end

function mod:ShadeShiftTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264027), shadeShiftCount)
	self:CDBar(1264027, eventInfo.duration, barText, nil, eventInfo.id)
	shadeShiftCount = shadeShiftCount + 1
	return {
		msg = barText,
		key = 1264027,
		callback = function()
			self:Message(1264027, "cyan", barText)
			self:PlaySound(1264027, "long")
		end
	}
end

function mod:GetEmIckTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264363), getEmIckCount)
	self:CDBar(1264363, eventInfo.duration, barText, nil, eventInfo.id)
	getEmIckCount = getEmIckCount + 1
	return {
		msg = barText,
		key = 1264363,
		callback = function()
			self:Message(1264363, "red", barText)
			self:PlaySound(1264363, "alert")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Barrage(args)
	if barrage then return end
	barrage = true
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 18)
end

function mod:BarrageEnd(args)
	barrage = false
	self:StopBar(args.spellName)
end

function mod:ToxicWaste(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(70274, "underyou")
		self:PlaySound(70274, "underyou")
	end
end

function mod:PoisonNova(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 5)
end

function mod:UNIT_AURA(_, unit)
	local name = self:UnitDebuff(unit, 68987) -- Pursuit
	local n = self:UnitName(unit)
	if pursuitWarned[n] and not name then
		pursuitWarned[n] = nil
	elseif name and not pursuitWarned[n] then
		self:TargetMessageOld(68987, n, "yellow", "alert")
		pursuitWarned[n] = true
	end
end
