--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rukhran", 1209, 967)
if not mod then return end
mod:RegisterEnableMob(76143)
mod:SetEncounterID(1700)
mod:SetRespawnTime(15)
if mod:Retail() then
	mod:SetPrivateAuraSounds({
		{1253511, sound = "info"}, -- Burning Pursuit
		{1253520, sound = "alarm"}, -- Burning Claws
	})
end

--------------------------------------------------------------------------------
-- Locals
--

local quillsWarn = 100

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{153794, "TANK"}, -- Pierce Armor
		153810, -- Summon Solar Flare
		159382, -- Quills
		167757, -- Fixate
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("RAID_BOSS_WHISPER")
	self:Log("SPELL_CAST_START", "PierceArmor", 153794)
	self:Log("SPELL_CAST_START", "SummonSolarFlare", 153810)
	self:Log("SPELL_CAST_START", "Quills", 159382)
end

function mod:OnEngage()
	quillsWarn = 100
	self:RegisterUnitEvent("UNIT_HEALTH", "QuillsWarn", "boss1")
	self:Bar(153794, 10.5) -- Pierce Armor
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local burningClawsCount = 1
local sunbreakCount = 1
local searingQuillsCount = 1
local count12 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1253519, "TANK_HEALER"}, -- Burning Claws
			1253510, -- Sunbreak
			159382, -- Searing Quills
			{1253511, "PRIVATE"}, -- Burning Pursuit
			{1253520, "PRIVATE"}, -- Burning Claws
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		burningClawsCount = 1
		sunbreakCount = 1
		searingQuillsCount = 1
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
	local duration = math.floor(eventInfo.duration + 0.5)
	local barInfo
	if duration == 5 or (duration == 12 and count12 % 2 == 0) then -- Burning Claws
		barInfo = self:BurningClawsTimeline(eventInfo)
	elseif (duration == 12 and count12 % 2 == 1) or duration == 21 then -- Sunbreak
		barInfo = self:SunbreakTimeline(eventInfo)
	elseif duration == 38 then -- Searing Quills
		barInfo = self:SearingQuillsTimeline(eventInfo)
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

function mod:BurningClawsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253519), burningClawsCount)
	self:CDBar(1253519, eventInfo.duration, barText, nil, eventInfo.id)
	burningClawsCount = burningClawsCount + 1
	return {
		msg = barText,
		key = 1253519,
		callback = function()
			self:Message(1253519, "purple", barText)
			if self:Tank() then
				self:PlaySound(1253519, "alarm")
			else
				self:PlaySound(1253519, "alert")
			end
		end
	}
end

function mod:SunbreakTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1253510), sunbreakCount)
	self:CDBar(1253510, eventInfo.duration, barText, nil, eventInfo.id)
	sunbreakCount = sunbreakCount + 1
	return {
		msg = barText,
		key = 1253510,
		callback = function()
			self:Message(1253510, "cyan", barText)
			self:PlaySound(1253510, "info")
		end
	}
end

function mod:SearingQuillsTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(159382), searingQuillsCount)
	self:CDBar(159382, eventInfo.duration, barText, nil, eventInfo.id)
	searingQuillsCount = searingQuillsCount + 1
	return {
		msg = barText,
		key = 159382,
		--callback = function() -- has Blizzard message
			--self:Message(159382, "orange", barText)
			--self:PlaySound(159382, "long")
		--end
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RAID_BOSS_WHISPER()
	-- RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_fixated_state_red:20|tA Solar Flare has |cFFFF0000|Hspell:176544|h[Fixated]|h|r on you! If it reaches you it will |cFFFF0000|Hspell:153828|h[Explode]|h|r!#Solar Flare#1#true
	self:Message(167757, "blue", CL.you:format(self:SpellName(167757)))
	self:PlaySound(167757, "warning")
end

function mod:PierceArmor(args)
	self:Message(args.spellId, "purple")
	self:Bar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SummonSolarFlare(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
end

function mod:Quills(args)
	self:Message(args.spellId, "orange", CL.percent:format(quillsWarn, args.spellName))
	self:Bar(args.spellId, 17)
	self:PlaySound(args.spellId, "long")
end

function mod:QuillsWarn(event, unit)
	local hp = self:GetHealth(unit)
	if (hp < 67 and quillsWarn == 100) or (hp < 27 and quillsWarn == 60) then
		quillsWarn = quillsWarn - 40
		self:Message(159382, "green", CL.soon:format(self:SpellName(159382)), false)
		if quillsWarn == 20 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
