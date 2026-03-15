--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1753, 1982)
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
mod:SetEncounterID(2068)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1265426, sound = "alarm"}, -- Discordant Beam
	{1265650, sound = "alert"}, -- Anguish
})

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "L'ura Active"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		247795, -- Call to the Void
		248535, -- Naaru's Lament
		247930, -- Umbral Cadence
		245164, -- Fragment of Despair
		247816, -- Backlash
		249009, -- Grand Shift
	},{
		[249009] = "mythic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallToTheVoid", 247795)
	self:Log("SPELL_AURA_APPLIED", "NaarusLament", 248535)
	self:Log("SPELL_CAST_SUCCESS", "UmbralCadence", 247930)
	self:Log("SPELL_CAST_SUCCESS", "FragmentofDespair", 245164)
	self:Log("SPELL_AURA_APPLIED", "Backlash", 247816)

	--[[ Mythic ]]--
	self:Log("SPELL_CAST_START", "GrandShift", 249009)
end

--------------------------------------------------------------------------------
-- Midnight Locals

local dirgeOfDespairCount = 1
local disintegrateCount = 1
local discordantBeamCount = 1
local grimChorusCount = 1
local symphonyOfTheEternalNightCount = 1
local backlashCount = 1
local count1_5 = 1
local activeBars = {}

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			"warmup",
			1265421, -- Dirge of Despair
			1264196, -- Disintegrate
			1265463, -- Discordant Beam
			1265689, -- Grim Chorus
			1266003, -- Symphony of the Eternal Night
			1266001, -- Backlash
			--{1265426, "PRIVATE"}, -- Discordant Beam
			{1265650, "PRIVATE"}, -- Anguish
		}
	end

	function mod:OnBossEnable()
	end

	mod:UseCustomTimers(true)
	function mod:OnEncounterStart()
		dirgeOfDespairCount = 1
		disintegrateCount = 1
		discordantBeamCount = 1
		grimChorusCount = 1
		symphonyOfTheEternalNightCount = 1
		backlashCount = 1
		count1_5 = 1
		activeBars = {}
		if self:ShouldShowBars() then
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
			self:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
		end
	end

	function mod:OnWin()
		activeBars = {}
	end
end

--------------------------------------------------------------------------------
-- Timeline Event Handlers
--

function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(_, eventInfo)
	if eventInfo.source ~= 0 then return end -- Enum.EncounterTimelineEventSource.Encounter
	local duration = math.floor(eventInfo.duration * 10.0 + 0.5) / 10.0
	local barInfo
	if duration == 1.5 and count1_5 % 2 == 1 then -- Dirge of Despair
		barInfo = self:DirgeOfDespairTimeline(eventInfo)
	elseif duration == 12 or duration == 5 then -- Disintegrate
		barInfo = self:DisintegrateTimeline(eventInfo)
	elseif duration == 24 or duration == 17 then -- Discordant Beam
		barInfo = self:DiscordantBeamTimeline(eventInfo)
	elseif duration == 35 or duration == 28 then -- Grim Chorus
		barInfo = self:GrimChorusTimeline(eventInfo)
	elseif duration == 1.5 and count1_5 % 2 == 0 then -- Symphony of the Eternal Night
		barInfo = self:SymphonyOfTheEternalNightTimeline(eventInfo)
	elseif duration == 20 then -- Backlash
		barInfo = self:BacklashTimeline(eventInfo)
	elseif not self:IsWiping() then
		self:ErrorForTimelineEvent(eventInfo)
	end
	if duration == 1.5 then
		count1_5 = count1_5 + 1
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

function mod:DirgeOfDespairTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1265421), dirgeOfDespairCount)
	self:CDBar(1265421, eventInfo.duration, barText, nil, eventInfo.id)
	dirgeOfDespairCount = dirgeOfDespairCount + 1
	return {
		msg = barText,
		key = 1265421,
		callback = function()
			self:Message(1265421, "red", barText)
			self:PlaySound(1265421, "warning")
		end
	}
end

function mod:DisintegrateTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1264196), disintegrateCount)
	self:CDBar(1264196, eventInfo.duration, barText, nil, eventInfo.id)
	disintegrateCount = disintegrateCount + 1
	return {
		msg = barText,
		key = 1264196,
		callback = function()
			self:Message(1264196, "yellow", barText)
			self:PlaySound(1264196, "alert")
		end
	}
end

function mod:DiscordantBeamTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1265463), discordantBeamCount)
	self:CDBar(1265463, eventInfo.duration, barText, nil, eventInfo.id)
	discordantBeamCount = discordantBeamCount + 1
	return {
		msg = barText,
		key = 1265463,
		callback = function()
			self:Message(1265463, "purple", barText)
			self:PlaySound(1265463, "alarm")
		end
	}
end

function mod:GrimChorusTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1265689), grimChorusCount)
	self:CDBar(1265689, eventInfo.duration, barText, nil, eventInfo.id)
	grimChorusCount = grimChorusCount + 1
	return {
		msg = barText,
		key = 1265689,
		cancelCallback = function()
			self:Message(1265689, "red", barText)
			self:PlaySound(1265689, "warning")
		end
	}
end

function mod:SymphonyOfTheEternalNightTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1266003), symphonyOfTheEternalNightCount)
	self:CDBar(1266003, eventInfo.duration, barText, nil, eventInfo.id)
	symphonyOfTheEternalNightCount = symphonyOfTheEternalNightCount + 1
	return {
		msg = barText,
		key = 1266003,
		callback = function()
			self:Message(1266003, "yellow", barText)
			self:PlaySound(1266003, "info")
		end
	}
end

function mod:BacklashTimeline(eventInfo)
	local barText = CL.count:format(self:SpellName(1266001), backlashCount)
	self:Message(1266001, "green", barText)
	self:Bar(1266001, eventInfo.duration, barText, nil, eventInfo.id)
	backlashCount = backlashCount + 1
	self:PlaySound(1266001, "long")
	return {
		msg = barText,
		key = 1266001,
	}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WarmupEarly() -- Called from trash module
	self:Bar("warmup", 30.2, L.warmup_text, "spell_priest_divinestar_shadow")
end

function mod:WarmupLate() -- Called from trash module
	self:Bar("warmup", 8.47, L.warmup_text, "spell_priest_divinestar_shadow")
end

function mod:CallToTheVoid(args)
	self:Message(args.spellId, "red")
	self:CDBar(245164, 11) -- Fragment of Despair
	self:PlaySound(args.spellId, "warning")
end

function mod:NaarusLament(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:UmbralCadence(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 10.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:FragmentofDespair(args)
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:Backlash(args)
	self:Message(args.spellId, "green")
	self:Bar(args.spellId, 12.5)
	self:PlaySound(args.spellId, "long")
end

function mod:GrandShift(args)
	self:Message(args.spellId, "orange")
	self:Bar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alarm")
end
