--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Garfrost", 658, 608)
if not mod then return end
mod:RegisterEnableMob(36494)
mod:SetEncounterID(mod:Classic() and 833 or 1999)
mod:SetRespawnTime(30)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{1261286, sound = "alarm"}, -- Throw Saronite
		{1261540, sound = "alarm"}, -- Orebreaker
		{1261799, sound = "underyou"}, -- Saronite Sludge
		{1261921, sound = "alert"}, -- Cryoshards
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{70381, "ICON"}, -- Deep Freeze
		68789, -- Throw Saronite
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DeepFreeze", 70381)
	self:Log("SPELL_AURA_REMOVED", "DeepFreezeRemoved", 70381)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Throw Saronite
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local throwSaroniteCount = 1
local orebreakerCount = 1
local glacialOverloadCount = 1
local cryostompCount = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1261299, -- Throw Saronite
			1261546, -- Orebreaker
			1262029, -- Glacial Overload
			1261847, -- Cryostomp
			{1261286, "PRIVATE"}, -- Throw Saronite
			{1261540, "PRIVATE"}, -- Orebreaker
			{1261799, "PRIVATE"}, -- Saronite Sludge
			{1261921, "PRIVATE"}, -- Cryoshards
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		throwSaroniteCount = 1
		orebreakerCount = 1
		glacialOverloadCount = 1
		cryostompCount = 1
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
	local duration = self:RoundNumber(eventInfo.duration, 1)
	local barInfo
	if duration == 7 then -- Throw Saronite
		barInfo = self:ThrowSaroniteTimeline(eventInfo)
	elseif duration == 20 then -- Orebreaker
		barInfo = self:OrebreakerTimeline(eventInfo)
	elseif duration == 33 then -- Glacial Overload
		barInfo = self:GlacialOverloadTimeline(eventInfo)
	elseif duration == 0 or duration == 41.5 then -- Cryostomp
		if duration == 0 then return end -- fake 0.001 Cryostomp bar
		barInfo = self:CryostompTimeline(eventInfo)
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

function mod:ThrowSaroniteTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1261299), throwSaroniteCount)
	self:CDBar(1261299, eventInfo.duration, barText, nil, eventInfo.id)
	throwSaroniteCount = throwSaroniteCount + 1
	return {
		msg = barText,
		key = 1261299,
		callback = function()
			self:Message(1261299, "red", barText)
			self:PlaySound(1261299, "alarm")
		end
	}
end

function mod:OrebreakerTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1261546), orebreakerCount)
	self:CDBar(1261546, eventInfo.duration, barText, nil, eventInfo.id)
	orebreakerCount = orebreakerCount + 1
	return {
		msg = barText,
		key = 1261546,
		callback = function()
			self:TargetMessageFromBlizzMessage(1, 1261546, "blue")
			self:Message(1261546, "purple", barText)
			if self:Tank() then
				self:PlaySound(1261546, "warning")
			else
				self:PlaySound(1261546, "info")
			end
		end
	}
end

function mod:GlacialOverloadTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1262029), glacialOverloadCount)
	self:CDBar(1262029, eventInfo.duration, barText, nil, eventInfo.id)
	glacialOverloadCount = glacialOverloadCount + 1
	return {
		msg = barText,
		key = 1262029,
		callback = function()
			self:Message(1262029, "yellow", barText)
			self:PlaySound(1262029, "warning")
		end
	}
end

function mod:CryostompTimeline(eventInfo)
	if cryostompCount > 1 then
		-- Cryostomp bars are canceled and re-added instead of going to Finished, so we alert when bars are added past the 1st one
		self:Message(1261847, "orange", CL.count:format(self:SpellName(1261847), cryostompCount - 1))
		self:PlaySound(1261847, "alert")
	end
	local barText = CL.count:format(self:SpellName(1261847), cryostompCount)
	self:CDBar(1261847, eventInfo.duration, barText, nil, eventInfo.id)
	cryostompCount = cryostompCount + 1
	return {
		msg = barText,
		key = 1261847,
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeepFreeze(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 14, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alert")
end

function mod:DeepFreezeRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER() -- Throw Saronite
	self:Message(68789, "red", CL.incoming:format(self:SpellName(68789)))
	self:PlaySound(68789, "alarm")
end
