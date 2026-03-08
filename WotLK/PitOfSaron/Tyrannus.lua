--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Scourgelord Tyrannus", 658, 610)
if not mod then return end
mod:RegisterEnableMob(36658, 36661)
mod:SetEncounterID(mod:Classic() and 837 or 2000)
mod:SetRespawnTime(30)
mod:SetStage(1)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{1262596, sound = "alarm"}, -- Scourgelord's Brand
		{1262772, sound = "alert"}, -- Rime Blast
		{1262930, sound = "none"}, -- Rotting Strikes
		{1263716, sound = "info"}, -- Frostbite
		{1276648, sound = "alarm"}, -- Bone Infusion
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{69172, "ICON"}, -- Overlord's Brand
		{69275, "ICON", "ME_ONLY_EMPHASIZE"}, -- Mark of Rimefang
		69167, -- Unholy Power
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Brand", 69172)
	self:Log("SPELL_AURA_APPLIED", "Mark", 69275)
	self:Log("SPELL_AURA_REMOVED", "MarkRemoved", 69275)
	self:Log("SPELL_AURA_REMOVED", "BrandRemoved", 69172)
	self:Log("SPELL_AURA_APPLIED", "Power", 69167)
end

--------------------------------------------------------------------------------
-- Midnight Locals
--

local rimeBlastCount = 1
local scourgelordsBrandCount = 1
local deathsGraspCount = 1
local armyOfTheDeadCount = 1
local iceBarrageCount = 1
local boneInfusionCount = 1
local count28 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			1262745, -- Rime Blast
			1262582, -- Scourgelord's Brand
			1263756, -- Death's Grasp
			1263406, -- Army of the Dead
			1276948, -- Ice Barrage
			1276648, -- Bone Infusion
			{1262596, "PRIVATE"}, -- Scourgelord's Brand
			{1262772, "PRIVATE"}, -- Rime Blast
			{1262930, "PRIVATE"}, -- Rotting Strikes
			{1263716, "PRIVATE"}, -- Frostbite
			--{1276648, "PRIVATE"}, -- Bone Infusion
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		rimeBlastCount = 1
		scourgelordsBrandCount = 1
		deathsGraspCount = 1
		armyOfTheDeadCount = 1
		iceBarrageCount = 1
		boneInfusionCount = 1
		count28 = 1
		activeBars = {}
		self:SetStage(1)
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
	if duration == 7 or (duration == 28 and count28 % 3 == 1) then -- Rime Blast
		barInfo = self:RimeBlastTimeline(eventInfo)
	elseif duration == 12 then -- Ice Barrage
		barInfo = self:IceBarrageTimeline(eventInfo)
	elseif duration == 14 or (duration == 28 and count28 % 3 == 2) then -- Scourgelord's Brand
		barInfo = self:ScourgelordsBrandTimeline(eventInfo)
	elseif duration == 24 then -- Death's Grasp
		barInfo = self:DeathsGraspTimeline(eventInfo)
	elseif duration == 52 then -- Army of the Dead
		barInfo = self:ArmyoftheDeadTimeline(eventInfo)
	elseif (duration == 28 and count28 % 3 == 0) then -- Bone Infusion
		barInfo = self:BoneInfusionTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 28 then
		count28 = count28 + 1
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

function mod:RimeBlastTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1262745), rimeBlastCount)
	self:CDBar(1262745, eventInfo.duration, barText, nil, eventInfo.id)
	rimeBlastCount = rimeBlastCount + 1
	return {
		msg = barText,
		key = 1262745,
		callback = function()
			self:Message(1262745, "orange", barText)
			self:PlaySound(1262745, "alarm")
		end
	}
end

function mod:IceBarrageTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1276948), iceBarrageCount)
	self:CDBar(1276948, eventInfo.duration, barText, nil, eventInfo.id)
	iceBarrageCount = iceBarrageCount + 1
	return {
		msg = barText,
		key = 1276948,
		callback = function()
			self:Message(1276948, "red", barText)
			self:PlaySound(1276948, "alarm")
		end
	}
end

function mod:ScourgelordsBrandTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1262582), scourgelordsBrandCount)
	self:CDBar(1262582, eventInfo.duration, barText, nil, eventInfo.id)
	scourgelordsBrandCount = scourgelordsBrandCount + 1
	return {
		msg = barText,
		key = 1262582,
		callback = function()
			self:Message(1262582, "yellow", barText)
			self:PlaySound(1262582, "alert")
		end
	}
end

function mod:DeathsGraspTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1263756), deathsGraspCount)
	self:CDBar(1263756, eventInfo.duration, barText, nil, eventInfo.id)
	deathsGraspCount = deathsGraspCount + 1
	return {
		msg = barText,
		key = 1263756,
		callback = function()
			self:Message(1263756, "red", barText)
			self:PlaySound(1263756, "alarm")
		end
	}
end

function mod:ArmyoftheDeadTimeline(eventInfo)
	-- there's no Finished for Bone Infusion so alert when the next Army of the Dead bar is added
	if armyOfTheDeadCount > 1 then
		self:SetStage(1)
		self:Message(1276648, "cyan", CL.count:format(self:SpellName(1276648), boneInfusionCount - 1)) -- Bone Infusion
		self:PlaySound(1276648, "long")
	end
	local barText = CL.count:format(self:SpellName(1263406), armyOfTheDeadCount)
	self:CDBar(1263406, eventInfo.duration, barText, nil, eventInfo.id)
	armyOfTheDeadCount = armyOfTheDeadCount + 1
	return {
		msg = barText,
		key = 1263406,
		callback = function()
			self:SetStage(2)
			self:Message(1263406, "cyan", barText)
			self:PlaySound(1263406, "long")
		end
	}
end

function mod:BoneInfusionTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1276648), boneInfusionCount)
	self:CDBar(1276648, eventInfo.duration, barText, nil, eventInfo.id)
	boneInfusionCount = boneInfusionCount + 1
	return {
		msg = barText,
		key = 1276648,
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Brand(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 8, args.destName)
	self:SecondaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:Mark(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:TargetBar(args.spellId, 7, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:MarkRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:BrandRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:SecondaryIcon(args.spellId)
end

function mod:Power(args)
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 10)
end
