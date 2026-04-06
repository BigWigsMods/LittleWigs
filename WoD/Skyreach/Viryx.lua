--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Sage Viryx", 1209, 968)
if not mod then return end
mod:RegisterEnableMob(76266)
mod:SetEncounterID(1701)
mod:SetRespawnTime(15)
if mod:Retail() then
	mod:SetPrivateAuraSounds({
		{153954, sound = "info"}, -- Cast Down
		{1253541, sound = "alert"}, -- Scorching Ray
		{1253543, sound = "none"}, -- Scorching Ray
		{1253531, sound = "alarm"}, -- Lens Flare
	})
end

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds_icon = "icon_petfamily_mechanical"
	L.solar_zealot = "Solar Zealot"
	L.construct = "Skyreach Shield Construct" -- NPC ID 76292
end

--------------------------------------------------------------------------------
-- Initialization
--

local solarZealotMarker = mod:AddMarkerOption(true, "npc", 8, "solar_zealot", 8)
function mod:GetOptions()
	return {
		153954, -- Cast Down
		solarZealotMarker,
		"adds",
		154055, -- Shielding
	},nil,{
		["adds"] = L.construct, -- Adds (Skyreach Shield Construct)
	}
end

function mod:OnRegister()
	-- delayed for custom locale
	solarZealotMarker = mod:AddMarkerOption(true, "npc", 8, "solar_zealot", 8)
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")

	self:Log("SPELL_CAST_START", "Shielding", 154055)
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:CDBar(153954, 15) -- Cast Down
	self:Bar("adds", 32, CL.add, L.adds_icon)
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local scorchingRayCount = 1
local solarBlastCount = 1
local castDownCount = 1
local lensFlareCount = 1
local count12 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1253538, -- Scorching Ray
			154396, -- Solar Blast
			153954, -- Cast Down
			1253840, -- Lens Flare
			--{153954, "PRIVATE"}, -- Cast Down
			{1253541, "PRIVATE"}, -- Scorching Ray
			{1253543, "PRIVATE"}, -- Scorching Ray
		}
	end

	function mod:OnRegister()
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		scorchingRayCount = 1
		solarBlastCount = 1
		castDownCount = 1
		lensFlareCount = 1
		count12 = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 5 or duration == 10 then -- Scorching Ray
		barInfo = self:ScorchingRayTimeline(eventInfo)
	elseif duration == 8 or (duration == 12 and count12 % 2 == 0) then -- Solar Blast
		barInfo = self:SolarBlastTimeline(eventInfo)
	elseif (duration == 12 and count12 % 2 == 1) then -- Cast Down
		barInfo = self:CastDownTimeline(eventInfo)
	elseif duration == 30 then -- Lens Flare
		barInfo = self:LensFlareTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 12 then
		count12 = count12 + 1
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

function mod:ScorchingRayTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253538), scorchingRayCount)
	self:CDBar(1253538, eventInfo.duration, barText, nil, eventInfo.id)
	scorchingRayCount = scorchingRayCount + 1
	return {
		msg = barText,
		key = 1253538,
		callback = function()
			self:Message(1253538, "yellow", barText)
			--self:PlaySound(1253538, "alert") Private Aura sound
		end
	}
end

function mod:SolarBlastTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(154396), solarBlastCount)
	self:CDBar(154396, eventInfo.duration, barText, nil, eventInfo.id)
	solarBlastCount = solarBlastCount + 1
	return {
		msg = barText,
		key = 154396,
		callback = function()
			self:Message(154396, "red", CL.casting:format(barText))
			self:PlaySound(154396, "alert")
		end
	}
end

function mod:CastDownTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(153954), castDownCount)
	self:CDBar(153954, eventInfo.duration, barText, nil, eventInfo.id)
	castDownCount = castDownCount + 1
	return {
		msg = barText,
		key = 153954,
		callback = function()
			self:Message(153954, "cyan", barText)
			self:PlaySound(153954, "warning")
		end
	}
end

function mod:LensFlareTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253840), lensFlareCount)
	self:CDBar(1253840, eventInfo.duration, barText, nil, eventInfo.id)
	lensFlareCount = lensFlareCount + 1
	return {
		msg = barText,
		key = 1253840,
		callback = function()
			self:Message(1253840, "orange", barText)
			self:PlaySound(1253840, "alarm")
		end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetOption(solarZealotMarker) then
		for i = 1, 5 do
			local unit = ("boss%d"):format(i)
			local guid = self:UnitGUID(unit)
			if self:MobId(guid) == 76267 then -- Solar Zealot
				self:CustomIcon(false, unit, 8)
				break
			end
		end
	end
end

do
	local function bossTarget(self, name)
		self:TargetMessage(153954, "cyan", name)
		self:PlaySound(153954, "warning", nil, name)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if not self:IsSecret(spellId) and spellId == 153954 then -- Cast Down
			self:GetUnitTarget(bossTarget, 0.7, self:UnitGUID(unit))
			self:CDBar(spellId, 37) -- 37-40
		elseif not self:IsSecret(spellId) and spellId == 154049 then -- Call Adds
			self:Message("adds", "red", CL.add_spawned, L.adds_icon) -- Cog icon
			self:CDBar("adds", 58, CL.add, L.adds_icon) -- 57-60
			self:PlaySound("adds", "info")
		end
	end
end

function mod:Shielding(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end
