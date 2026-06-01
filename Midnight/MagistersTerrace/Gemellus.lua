--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gemellus", 2811, 2660)
if not mod then return end
mod:SetEncounterID(3073)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1224401, sound = "underyou", note = CL.debuffUnderYouNote}, -- Cosmic Radiation
	{1284958, sound = "alert", note = CL.debuffPossibleAfterCastNote:format(CL.extra:format(mod:SpellName(1284954), CL.pools))}, -- Cosmic Sting
	{1224104, sound = "underyou", note = CL.debuffUnderYouNote}, -- Void Secretions
	{1224299, sound = "warning", note = CL.grip}, -- Astral Grasp
	{1253709, sound = "warning", note = CL.break_shield}, -- Neural Link
})

--------------------------------------------------------------------------------
-- Locals
--

local triplicateCount = 1
local cosmicStingCount = 1
local neuralLinkCount = 1
local astralGraspCount = 1
local count5 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1223847] = {1223847, CL.percent:format(50, mod:SpellName(1223847)), notes = {CL.generalNote, CL.messageNote}, original = false}, -- Triplicate
	[1284954] = {CL.pools}, -- Cosmic Sting (Pools)
	[1253709] = {CL.break_shields, CL.you:format(CL.break_shield), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1253709, CL.you:format(mod:SpellName(1253709))}}, -- Neural Link (Break Shields)
	[1224299] = {CL.grips, CL.you:format(CL.grip), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1224299, CL.you:format(mod:SpellName(1224299))}}, -- Astral Grasp (Grips)
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		1223847, -- Triplicate
		1284954, -- Cosmic Sting
		{1253709, "ME_ONLY_EMPHASIZE"}, -- Neural Link
		{1224299, "ME_ONLY_EMPHASIZE"}, -- Astral Grasp
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	triplicateCount = 1
	cosmicStingCount = 1
	neuralLinkCount = 1
	astralGraspCount = 1
	count5 = 1
	activeBars = {}
	if self:ShouldShowBars() then
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
		self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration > 60 then return end -- always canceled
	if duration == 5 and count5 == 1 then -- Triplicate
		barInfo = self:TriplicateTimeline(eventInfo)
	elseif duration == 8 or (duration == 5 and count5 >= 2) then -- Cosmic Sting
		barInfo = self:CosmicStingTimeline(eventInfo)
	elseif duration == 16 then -- Neural Link
		barInfo = self:NeuralLinkTimeline(eventInfo)
	elseif duration == 29 then -- Astral Grasp
		barInfo = self:AstralGraspTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 5 then
		count5 = count5 + 1
	end
	if barInfo then
		activeBars[eventInfo.id] = barInfo
	end
end

function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(_, eventID)
	local state = C_EncounterTimeline.GetEventState(eventID)
	if state == 1 and triplicateCount == 2 then -- Timers should only pause at 50%
		triplicateCount = 3
		self:StopBlizzMessages(1)
		self:Message(1223847, "cyan", self:GetRename(1223847, 2)) -- 50% - Triplicate
		self:PlaySound(1223847, "info")
	end

	local barInfo = activeBars[eventID]
	if barInfo then
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

function mod:TriplicateTimeline(eventInfo) -- Triplicate / Split / Adds
	local barText = self:GetRename(1223847)
	self:CDBar(1223847, eventInfo.duration, barText, nil, eventInfo.id)
	triplicateCount = triplicateCount + 1
	return {
		msg = barText,
		key = 1223847,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1223847, "cyan", barText)
			self:PlaySound(1223847, "info")
		end
	}
end

function mod:CosmicStingTimeline(eventInfo) -- Pools
	local barText = CL.count:format(self:GetRename(1284954), cosmicStingCount)
	self:CDBar(1284954, eventInfo.duration, barText, nil, eventInfo.id)
	cosmicStingCount = cosmicStingCount + 1
	return {
		msg = barText,
		key = 1284954,
		callback = function()
			self:Message(1284954, "yellow", barText)
			self:PlaySound(1284954, "alert")
		end
	}
end

do
	local function IfOnMe(self)
		self:PlaySound(1253709, "warning", nil, self:UnitName("player")) -- Debuff was demoted from being a PA
	end
	function mod:NeuralLinkTimeline(eventInfo) -- Break Shields
		local barText = CL.count:format(self:GetRename(1253709), neuralLinkCount)
		self:CDBar(1253709, eventInfo.duration, barText, nil, eventInfo.id)
		neuralLinkCount = neuralLinkCount + 1
		return {
			msg = barText,
			key = 1253709,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1253709, 1, false, self:GetRename(1253709, 2), nil, nil, IfOnMe)
				--self:PlaySound(1253709, "warning") -- PA sound
			end
		}
	end
end

do
	local function IfOnMe(self)
		self:PlaySound(1224299, "warning", nil, self:UnitName("player")) -- Debuff was demoted from being a PA
	end
	function mod:AstralGraspTimeline(eventInfo) -- Grips
		local barText = CL.count:format(self:GetRename(1224299), astralGraspCount)
		self:CDBar(1224299, eventInfo.duration, barText, nil, eventInfo.id)
		astralGraspCount = astralGraspCount + 1
		return {
			msg = barText,
			key = 1224299,
			callback = function()
				self:PersonalMessageFromBlizzMessage(1224299, 1, false, self:GetRename(1224299, 2), nil, nil, IfOnMe)
				--self:PlaySound(1224299, "warning") -- PA sound
			end
		}
	end
end
