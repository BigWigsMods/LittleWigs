--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Saprish", 1753, 1980)
if not mod then return end
mod:RegisterEnableMob(122316, 122319, 125340) -- Saprish, Darkfang, Duskwing
mod:SetEncounterID(2066)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{245742, sound = "alert", note = CL.bleed}, -- Shadow Pounce
	{246026, sound = "alarm", note = CL.debuffWalkIntoObjectNote:format(mod:SpellName(246026))}, -- Void Bomb
	{1263523, sound = "info", note = CL.debuffDotAfterCastNote:format(CL.extra:format(mod:SpellName(1263523), CL.explosion))}, -- Overload
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

local dreadScreechCount = 1
local shadowPounceCount = 1
local voidBombCount = 1
local phaseDashCount = 1
local overloadCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Renames
--

if mod:Retail() then -- Midnight+
	mod:SetRenames({
		[248831] = {CL.kick}, -- Dread Screech (Kick)
		[245742] = {CL.bleed}, -- Shadow Pounce (Bleed)
		[1248219] = {CL.bombs}, -- Void Bomb (Bombs)
		[1280065] = {CL.clear_bombs}, -- Phase Dash (Clear Bombs)
		[1263523] = {CL.explosion}, -- Overload (Explosion)
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			-- Shadewing
			248831, -- Dread Screech
			-- Darkfang
			245742, -- Shadow Pounce
			-- Saprish
			1248219, -- Void Bomb
			1280065, -- Phase Dash
			1263523, -- Overload
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		dreadScreechCount = 1
		shadowPounceCount = 1
		voidBombCount = 1
		phaseDashCount = 1
		overloadCount = 1
		activeBars = {}
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
			self:SendMessage("BigWigs_BlockBlizzMessages")
			self:RegisterEvent("ENCOUNTER_WARNING")
			self:CDBar(248831, 5.2, CL.count:format(self:GetRename(248831), dreadScreechCount))
		end
	end

	function mod:OnWin()
		activeBars = {}
	end

	function mod:OnBossDisable()
		self:SendMessage("BigWigs_AllowBlizzMessages")
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
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

function mod:ENCOUNTER_WARNING(_, info) -- Kick
	if info.severity == 1 then -- Dread Screech
		local msg = CL.count:format(self:GetRename(248831))
		self:StopBar(msg)
		self:Message(248831, "red", msg, dreadScreechCount)
		dreadScreechCount = dreadScreechCount + 1
		self:CDBar(248831, 15.7, CL.count:format(self:GetRename(248831), dreadScreechCount))
		self:PlaySound(248831, "alarm")
	end
end

function mod:ShadowPounceTimeline(eventInfo) -- Bleed / Leap
	local barText = CL.count:format(self:GetRename(245742), shadowPounceCount)
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

function mod:VoidBombTimeline(eventInfo) -- Bombs
	local barText = CL.count_amount:format(self:GetRename(1248219), voidBombCount, 2)
	self:CDBar(1248219, eventInfo.duration, barText, nil, eventInfo.id)
	voidBombCount = voidBombCount + 1
	if voidBombCount == 3 then voidBombCount = 1 end
	return {
		msg = barText,
		key = 1248219,
		callback = function()
			self:Message(1248219, "cyan", barText)
			self:PlaySound(1248219, "info")
		end
	}
end

function mod:PhaseDashTimeline(eventInfo) -- Clear Bombs / Spread
	local barText = CL.count:format(self:GetRename(1280065), phaseDashCount)
	self:CDBar(1280065, eventInfo.duration, barText, nil, eventInfo.id)
	phaseDashCount = phaseDashCount + 1
	self:ScheduleTimer(function()
		self:StopBar(barText)
		self:Message(1280065, "orange", barText)
		self:PlaySound(1280065, "warning")
	end, eventInfo.duration)
	return {
		msg = barText,
		key = 1280065,
		callback = function()
			self:Error("Phase Dash now has a callback")
		end
	}
end

function mod:OverloadTimeline(eventInfo) -- Explosion
	local barText = CL.count:format(self:GetRename(1263523), overloadCount)
	self:CDBar(1263523, eventInfo.duration, barText, nil, eventInfo.id)
	overloadCount = overloadCount + 1
	return {
		msg = barText,
		key = 1263523,
		cancelCallback = function()
			self:Message(1263523, "yellow", barText)
			self:PlaySound(1263523, "long")
		end,
		callback = function()
			self:Error("Overload now has a callback")
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
