--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Araknath", 1209, 966)
if not mod then return end
mod:RegisterEnableMob(76141)
mod:SetEncounterID(1699)
mod:SetRespawnTime(23) -- respawns 11s after, unattackable for a while
if mod:Retail() then
	mod:SetPrivateAuraSounds({
		{154150, sound = "alert"}, -- Light Ray
		{1279002, sound = "warning"}, -- Blast Wave
		{154132, sound = "warning"}, -- Fiery Smash
	})
end

--------------------------------------------------------------------------------
-- Locals
--

local smashCount, burstCount = 0, 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		154159, -- Energize
		{154110, "TANK"}, -- Smash
		154135, -- Burst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Energize", 154159)
	self:Log("SPELL_CAST_START", "Smash", 154110, 154113)
	self:Log("SPELL_CAST_START", "Burst", 154135)
end

function mod:OnEngage()
	smashCount, burstCount = 0, 0
	self:CDBar(154159, 17) -- Energize
	self:CDBar(154135, 20) -- Burst
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local fierySmashCount = 1
local energizeCount = 1
local supernovaCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			154110, -- Fiery Smash
			154162, -- Defensive Protocol
			154135, -- Supernova
			{154150, "PRIVATE"}, -- Light Ray
			{1279002, "PRIVATE"}, -- Blast Wave
			{154132, "PRIVATE"}, -- Fiery Smash
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		fierySmashCount = 1
		energizeCount = 1
		supernovaCount = 1
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
	if duration == 5 or duration == 10 or duration == 15 then -- Fiery Smash
		barInfo = self:FierySmashTimeline(eventInfo)
	elseif duration == 6 or duration == 24 then -- Energize
		barInfo = self:EnergizeTimeline(eventInfo)
	elseif duration == 50 then -- Supernova
		barInfo = self:SupernovaTimeline(eventInfo)
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

function mod:FierySmashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(154110), fierySmashCount)
	self:CDBar(154110, eventInfo.duration, barText, nil, eventInfo.id)
	fierySmashCount = fierySmashCount + 1
	return {
		msg = barText,
		key = 154110,
		callback = function()
			self:Message(154110, "yellow", barText)
			self:PlaySound(154110, "alarm")
		end
	}
end

function mod:EnergizeTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(154162), energizeCount)
	self:CDBar(154162, eventInfo.duration, barText, nil, eventInfo.id)
	energizeCount = energizeCount + 1
	return {
		msg = barText,
		key = 154162,
		--callback = function() -- has Blizzard message
			--self:Message(154162, "yellow", barText)
			--self:PlaySound(154162, "alarm")
		--end
	}
end

function mod:SupernovaTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(154135), supernovaCount)
	self:CDBar(154135, eventInfo.duration, barText, nil, eventInfo.id)
	supernovaCount = supernovaCount + 1
	return {
		msg = barText,
		key = 154135,
		callback = function()
			self:Message(154135, "red", barText)
			self:PlaySound(154135, "info")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:Energize(args)
		if args.time - prev > 5 then -- More than 1 in Challenge Mode
			prev = args.time
			self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
			self:Bar(args.spellId, 23)
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:Smash()
	self:Message(154110, "orange")
	smashCount = smashCount + 1
	self:CDBar(154110, smashCount % 2 == 0 and 14.6 or 8.5)
	self:PlaySound(154110, "warning")
end

function mod:Burst(args)
	burstCount = burstCount + 1
	self:Message(args.spellId, "red", CL.count:format(args.spellName, burstCount))
	self:CDBar(args.spellId, 23)
	self:PlaySound(args.spellId, "info")
end
