--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zaen Bladesorrow", 2813, 2680)
if not mod then return end
mod:SetEncounterID(3102)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{474515, sound = "alert"}, -- Heartstop Poison
	{474545, sound = "warning"}, -- Murder in a Row
	{1214352, sound = "alarm"}, -- Fire Bomb
})

--------------------------------------------------------------------------------
-- Locals
--

local killingSpreeCount = 1
local sameDayDeliveryCount = 1
local fireBombCount = 1
local envenomCount = 1
local murderInARowCount = 1
local activeBars = {}
local backupBars = {}

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[474478] = {474478},  -- Killing Spree
	[474765] = {474765},  -- Same-Day Delivery
	[1214357] = {1214357, CL.you:format(mod:SpellName(1214357)), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1214357, CL.you:format(mod:SpellName(1214357))}}, -- Fire Bomb
	[1222795] = {1222795}, -- Envenom
	[1218347] = {1218347}, -- Murder in a Row
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		474478, -- Killing Spree
		474765, -- Same-Day Delivery
		1214357, -- Fire Bomb
		1222795, -- Envenom
		1218347, -- Murder in a Row
	}
end

mod:UseCustomTimers(true)
function mod:OnEncounterStart()
	killingSpreeCount = 1
	sameDayDeliveryCount = 1
	fireBombCount = 1
	envenomCount = 1
	murderInARowCount = 1
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

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = self:RoundNumber(eventInfo.duration, 0)
	local barInfo
	if duration == 8 then -- Killing Spree
		barInfo = self:KillingSpreeTimeline(eventInfo)
	elseif duration == 12 or duration == 16 then -- Same-Day Delivery
		barInfo = self:SameDayDeliveryTimeline(eventInfo)
	elseif duration == 18 then -- Fire Bomb
		barInfo = self:FireBombTimeline(eventInfo)
	elseif duration == 26 then -- Envenom
		barInfo = self:EnvenomTimeline(eventInfo)
	elseif duration == 36 then -- Murder in a Row
		barInfo = self:MurderInARowTimeline(eventInfo)
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

function mod:KillingSpreeTimeline(eventInfo) -- Killing Spree
	local barText = CL.count:format(self:GetRename(474478), killingSpreeCount)
	self:CDBar(474478, eventInfo.duration, barText, nil, eventInfo.id)
	killingSpreeCount = killingSpreeCount + 1
	return {
		msg = barText,
		key = 474478,
		callback = function()
			self:Message(474478, "red", barText)
			self:PlaySound(474478, "info")
		end
	}
end

function mod:SameDayDeliveryTimeline(eventInfo) -- Same-Day Delivery
	local barText = CL.count:format(self:GetRename(474765), sameDayDeliveryCount)
	self:CDBar(474765, eventInfo.duration, barText, nil, eventInfo.id)
	sameDayDeliveryCount = sameDayDeliveryCount + 1
	return {
		msg = barText,
		key = 474765,
		callback = function()
			self:Message(474765, "yellow", barText)
			self:PlaySound(474765, "alert")
		end
	}
end

function mod:FireBombTimeline(eventInfo) -- Fire Bomb
	local barText = CL.count:format(self:GetRename(1214357), fireBombCount)
	self:CDBar(1214357, eventInfo.duration, barText, nil, eventInfo.id)
	fireBombCount = fireBombCount + 1
	return {
		msg = barText,
		key = 1214357,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1214357, 1, false, self:GetRename(1214357, 2))
			self:Message(1214357, "orange", barText)
			self:PlaySound(1214357, "alarm")
		end
	}
end

function mod:EnvenomTimeline(eventInfo) -- Envenom
	local barText = CL.count:format(self:GetRename(1222795), envenomCount)
	self:CDBar(1222795, eventInfo.duration, barText, nil, eventInfo.id)
	envenomCount = envenomCount + 1
	return {
		msg = barText,
		key = 1222795,
		callback = function()
			self:Message(1222795, "purple", barText)
			self:PlaySound(1222795, "alert")
		end
	}
end

function mod:MurderInARowTimeline(eventInfo) -- Murder in a Row
	local barText = CL.count:format(self:GetRename(1218347), murderInARowCount)
	self:CDBar(1218347, eventInfo.duration, barText, nil, eventInfo.id)
	murderInARowCount = murderInARowCount + 1
	return {
		msg = barText,
		key = 1218347,
		callback = function() -- has Blizzard alert
			self:StopBlizzMessages(1)
			self:Message(1218347, "cyan", barText)
			-- private aura sound
		end
	}
end
