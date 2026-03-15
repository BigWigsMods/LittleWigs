--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Saprish", 1753, 1980)
if not mod then return end
mod:RegisterEnableMob(122316, 122319, 125340) -- Saprish, Darkfang, Duskwing
mod:SetEncounterID(2066)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{245742, sound = "alert"}, -- Shadow Pounce
	{246026, sound = "alarm"}, -- Void Bomb
	{1263523, sound = "info"}, -- Overload
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Saprish ]]--
		245873, -- Void Trap
		247206, -- Overload Trap
		{247245, "SAY"}, -- Umbral Flanking
		--[[ Darkfang ]]--
		245802, -- Ravaging Darkness
		--[[ Duskwing (Mythic) ]]--
		248831, -- Dread Screech
	},{
		[248831] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")

	--[[ Saprish ]]--
	self:Log("SPELL_CAST_SUCCESS", "VoidTrap", 247175)
	self:Log("SPELL_CAST_SUCCESS", "UmbralFlanking", 247245)
	self:Log("SPELL_AURA_APPLIED", "UmbralFlankingApplied", 247245)

	--[[ Darkfang ]]--
	self:Log("SPELL_CAST_START", "RavagingDarkness", 245802)
	self:Log("SPELL_DAMAGE", "RavagingDarknessDamage", 245803)
	self:Log("SPELL_MISSED", "RavagingDarknessDamage", 245803)

	--[[ Duskwing (Mythic) ]]--
	self:Log("SPELL_CAST_START", "DreadScreech", 248831)
end

function mod:OnEngage()
	self:Bar(245802, 3) -- Ravaging Darkness
	if self:Mythic() then
		self:Bar(248831, 5.5) -- Dread Screech
	end
	self:Bar(245873, 8) -- Void Trap
	self:Bar(247206, 12) -- Overload Trap
	self:Bar(247245, 20.5) -- Umbral Flanking
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local shadowPounceCount = 1
local voidBombCount = 1
local phaseDashCount = 1
local overloadCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			245742, -- Shadow Pounce
			1248219, -- Void Bomb
			1280065, -- Phase Dash
			1263523, -- Overload
			--{245742, "PRIVATE"}, -- Shadow Pounce
			--{246026, "PRIVATE"}, -- Void Bomb
			--{1263523, "PRIVATE"}, -- Overload
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		shadowPounceCount = 1
		voidBombCount = 1
		phaseDashCount = 1
		overloadCount = 1
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
	if duration == 4 or duration == 12 then -- Shadow Pounce
		barInfo = self:ShadowPounceTimeline(eventInfo)
	elseif duration == 6 or duration == 10 then -- Void Bomb
		barInfo = self:VoidBombTimeline(eventInfo)
	elseif duration == 20 then -- Phase Dash
		barInfo = self:PhaseDashTimeline(eventInfo)
	elseif duration == 32 then -- Overload
		barInfo = self:OverloadTimeline(eventInfo)
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

function mod:ShadowPounceTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(245742), shadowPounceCount)
	self:CDBar(245742, eventInfo.duration, barText, nil, eventInfo.id)
	shadowPounceCount = shadowPounceCount + 1
	return {
		msg = barText,
		key = 245742,
		callback = function()
			self:Message(245742, "red", barText)
			self:PlaySound(245742, "alert")
		end
	}
end

function mod:VoidBombTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1248219), voidBombCount)
	self:CDBar(1248219, eventInfo.duration, barText, nil, eventInfo.id)
	voidBombCount = voidBombCount + 1
	return {
		msg = barText,
		key = 1248219,
		callback = function()
			self:Message(1248219, "cyan", barText)
			self:PlaySound(1248219, "info")
		end
	}
end

function mod:PhaseDashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1280065), phaseDashCount)
	self:CDBar(1280065, eventInfo.duration, barText, nil, eventInfo.id)
	phaseDashCount = phaseDashCount + 1
	return {
		msg = barText,
		key = 1280065,
		callback = function()
			self:Message(1280065, "orange", barText)
			self:PlaySound(1280065, "alarm")
		end
	}
end

function mod:OverloadTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263523), overloadCount)
	self:CDBar(1263523, eventInfo.duration, barText, nil, eventInfo.id)
	overloadCount = overloadCount + 1
	return {
		msg = barText,
		key = 1263523,
		cancelCallback = function()
			self:Message(1263523, "yellow", barText)
			self:PlaySound(1263523, "long")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if not self:IsSecret(spellId) and spellId == 247206 then -- Overload Trap
		self:Message(spellId, "yellow")
		self:Bar(spellId, 20.7)
		self:PlaySound(spellId, "alarm")
	end
end

function mod:VoidTrap()
	self:Message(245873, "cyan")
	self:Bar(245873, 15.8)
	self:PlaySound(245873, "info")
end

function mod:UmbralFlanking(args)
	self:Bar(args.spellId, 35.2)
end

do
	local list = {}
	function mod:UmbralFlankingApplied(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, list, "orange", "alert")
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Umbral Flanking")
		end
	end
end

function mod:RavagingDarkness(args)
	self:Message(args.spellId, "yellow")
	self:Bar(args.spellId, 9.7)
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:RavagingDarknessDamage(args)
		if self:Me(args.destGUID) then
			if args.time - prev > 1.5 then
				prev = args.time
				self:PersonalMessage(245802, "underyou")
				self:PlaySound(245802, "underyou")
			end
		end
	end
end

function mod:DreadScreech(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 15)
	self:PlaySound(args.spellId, "warning")
end
