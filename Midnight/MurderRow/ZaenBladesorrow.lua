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
		{474515, "PRIVATE"}, -- Heartstop Poison
		--{474545, "PRIVATE"}, -- Murder in a Row
		--{1214352, "PRIVATE"}, -- Fire Bomb
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

function mod:KillingSpreeTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(474478), killingSpreeCount)
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

function mod:SameDayDeliveryTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(474765), sameDayDeliveryCount)
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

function mod:FireBombTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1214357), fireBombCount)
	self:CDBar(1214357, eventInfo.duration, barText, nil, eventInfo.id)
	fireBombCount = fireBombCount + 1
	return {
		msg = barText,
		key = 1214357,
		callback = function()
			self:Message(1214357, "orange", barText)
			self:PlaySound(1214357, "alarm")
		end
	}
end

function mod:EnvenomTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1222795), envenomCount)
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

function mod:MurderInARowTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1218347), murderInARowCount)
	self:CDBar(1218347, eventInfo.duration, barText, nil, eventInfo.id)
	murderInARowCount = murderInARowCount + 1
	return {
		msg = barText,
		key = 1218347,
		--callback = function() -- has Blizzard alert
			--self:Message(1218347, "yellow", barText)
			--self:PlaySound(1218347, "long")
		--end
	}
end
