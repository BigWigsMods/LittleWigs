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
		{1261286, sound = "warning"}, -- Throw Saronite
		{1261540, sound = "warning", note = CL.tank_hit}, -- Orebreaker
		{1261799, sound = "underyou", note = CL.debuffUnderYouNote}, -- Saronite Sludge
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
-- Midnight Renames
--

if mod:Retail() then -- Midnight+
	mod:SetRenames({
		[1261299] = {1261299, CL.you:format(mod:SpellName(1261299)), notes = {CL.generalNote, CL.messageOnYouNote}, original = false}, -- Throw Saronite
		[1261546] = {CL.tank_hit, CL.you:format(CL.tank_hit), notes = {CL.generalNote, CL.messageOnYouNote}, original = {1261546, CL.you:format(mod:SpellName(1261546))}}, -- Orebreaker (Tank Hit)
		[1262029] = {CL.full_energy, CL.cast:format(CL.full_energy), notes = {CL.generalNote, CL.castTimerNote}, original = {1262029, CL.cast:format(mod:SpellName(1262029))}}, -- Glacial Overload (Full Energy)
		[1261847] = {CL.stomp}, -- Cryostomp (Stomp)
	})
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1261299, "ME_ONLY_EMPHASIZE"}, -- Throw Saronite
			{1261546, "ME_ONLY_EMPHASIZE"}, -- Orebreaker
			{1262029, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Glacial Overload
			1261847, -- Cryostomp
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

function mod:ThrowSaroniteTimeline(eventInfo) -- Throw Saronite / Place Rocks
	local barText = CL.count:format(self:GetRename(1261299), throwSaroniteCount)
	self:CDBar(1261299, eventInfo.duration, barText, nil, eventInfo.id)
	throwSaroniteCount = throwSaroniteCount + 1
	return {
		msg = barText,
		key = 1261299,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1261299, 5, false, self:GetRename(1261299, 2)) -- Takes about 4s between first application and second application
			self:Message(1261299, "yellow", barText)
			--self:PlaySound(1261299, "warning") -- PA sound
		end
	}
end

function mod:OrebreakerTimeline(eventInfo) -- Tank Hit
	local barText = CL.count:format(self:GetRename(1261546), orebreakerCount)
	self:CDBar(1261546, eventInfo.duration, barText, nil, eventInfo.id)
	orebreakerCount = orebreakerCount + 1
	return {
		msg = barText,
		key = 1261546,
		callback = function()
			self:PersonalMessageFromBlizzMessage(1261546, 1, false, self:GetRename(1261546, 2)) -- Tank only message
			--self:PlaySound(1261546, "warning") -- PA sound
			if not self:Tank() then
				self:Message(1261546, "purple", barText) -- Message for non-tanks
				self:PlaySound(1261546, "info")
			end
		end
	}
end

function mod:GlacialOverloadTimeline(eventInfo) -- Full Energy
	local barText = CL.count:format(self:GetRename(1262029), glacialOverloadCount)
	self:CDBar(1262029, eventInfo.duration, barText, nil, eventInfo.id)
	glacialOverloadCount = glacialOverloadCount + 1
	return {
		msg = barText,
		key = 1262029,
		callback = function()
			self:StopBlizzMessages(1)
			self:Message(1262029, "red", barText)
			self:CastBar(1262029, 5, 2, nil, eventInfo.id)
			self:PlaySound(1262029, "long")
		end
	}
end

function mod:CryostompTimeline(eventInfo) -- Stomp / Dodge / AoE
	if cryostompCount > 1 then
		-- Cryostomp bars are canceled and re-added instead of going to Finished, so we alert when bars are added past the 1st one
		self:Message(1261847, "orange", CL.count:format(self:GetRename(1261847), cryostompCount - 1))
		self:PlaySound(1261847, "alert")
	end
	local barText = CL.count:format(self:GetRename(1261847), cryostompCount)
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
