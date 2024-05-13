--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chrono-Lord Deios", 2451, 2479)
if not mod then return end
mod:RegisterEnableMob(184125) -- Chrono-Lord Deios
mod:SetEncounterID(2559)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_uldaman"
end

--------------------------------------------------------------------------------
-- Locals
--

local rewindTimeflowCount = 1
local wingBuffetCount = 1
local timeSinkCount = 1
local sandBreathCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		376325, -- Eternity Zone
		376208, -- Rewind Timeflow
		376049, -- Wing Buffet
		{377405, "SAY"}, -- Time Sink
		375727, -- Sand Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EternityZoneApplied", 376325)
	self:Log("SPELL_CAST_START", "RewindTimeflow", 376208)
	self:Log("SPELL_AURA_REMOVED", "RewindTimeflowOver", 376208)
	self:Log("SPELL_CAST_START", "WingBuffet", 376049)
	self:Log("SPELL_CAST_SUCCESS", "TimeSink", 377395)
	self:Log("SPELL_AURA_APPLIED", "TimeSinkApplied", 377405)
	self:Log("SPELL_CAST_START", "SandBreath", 375727)
end

function mod:OnEngage()
	rewindTimeflowCount = 1
	wingBuffetCount = 1
	timeSinkCount = 1
	sandBreathCount = 1
	self:StopBar(CL.active)
	if not self:Normal() then
		self:CDBar(377405, 5.4, CL.count:format(self:SpellName(377405), timeSinkCount)) -- Time Sink
	end
	self:CDBar(376049, 6.3, CL.count:format(self:SpellName(376049), wingBuffetCount)) -- Wing Buffet
	self:CDBar(375727, 12.1) -- Sand Breath
	self:CDBar(376208, 39.1, CL.count:format(self:SpellName(376208), rewindTimeflowCount)) -- Rewind Timeflow (1)
end

function mod:VerifyEnable(unit)
	-- the boss sticks around for a little RP after being defeated
	return self:GetHealth(unit) > 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 16.9, CL.active, L.warmup_icon)
end

do
	local prev = 0
	function mod:EternityZoneApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:RewindTimeflow(args)
	self:StopBar(CL.count:format(args.spellName, rewindTimeflowCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, rewindTimeflowCount))
	self:PlaySound(args.spellId, "long")
	rewindTimeflowCount = rewindTimeflowCount + 1
	self:Bar(args.spellId, 57.1, CL.count:format(args.spellName, rewindTimeflowCount))
	-- extend other timers if needed, 2s cast + 12s channel + .5s delay
	if self:BarTimeLeft(375727) < 14.5 then -- Sand Breath
		self:CDBar(375727, {14.5, 18.2}) -- Sand Breath
		-- Sand Breath always happens before Wing Buffet, and the
		-- soonest Wing Buffet can be after Sand Breath is 3.6s
		if self:BarTimeLeft(CL.count:format(self:SpellName(376049), wingBuffetCount)) < 18.1 then -- Wing Buffet
			self:CDBar(376049, {18.1, 23.1}, CL.count:format(self:SpellName(376049), wingBuffetCount))
		end
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(376049), wingBuffetCount)) < 14.5 then -- Wing Buffet
		self:CDBar(376049, {14.5, 23.1}, CL.count:format(self:SpellName(376049), wingBuffetCount))
	end
end

function mod:RewindTimeflowOver(args)
	self:Message(args.spellId, "yellow", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:WingBuffet(args)
	self:StopBar(CL.count:format(args.spellName, wingBuffetCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, wingBuffetCount))
	self:PlaySound(args.spellId, "alarm")
	wingBuffetCount = wingBuffetCount + 1
	-- pull:6.9, 23.0, 27.9, 23.0, 34.0, 23.0, 34.0, 23.0
	if wingBuffetCount == 3 then
		self:CDBar(args.spellId, 27.9, CL.count:format(args.spellName, wingBuffetCount))
	elseif wingBuffetCount % 2 == 0 then
		self:CDBar(args.spellId, 23.0, CL.count:format(args.spellName, wingBuffetCount))
	else
		self:CDBar(args.spellId, 34.0, CL.count:format(args.spellName, wingBuffetCount))
	end
end

do
	local playerList = {}

	function mod:TimeSink(args)
		if self:Normal() then
			-- this event fires on normal but no debuffs go out, ignore it
			return
		end
		playerList = {}
		self:StopBar(CL.count:format(args.spellName, timeSinkCount))
		timeSinkCount = timeSinkCount + 1
		-- pull:6.1, 20.6, 35.2, 23.1, 34.0, 23.1, 34.0
		if timeSinkCount == 2 then
			self:CDBar(377405, 20.6, CL.count:format(args.spellName, timeSinkCount))
		elseif timeSinkCount == 3 then
			self:CDBar(377405, 35.2, CL.count:format(args.spellName, timeSinkCount))
		elseif timeSinkCount % 2 == 0 then
			self:CDBar(377405, 23.1, CL.count:format(args.spellName, timeSinkCount))
		else
			self:CDBar(377405, 34.0, CL.count:format(args.spellName, timeSinkCount))
		end
	end

	function mod:TimeSinkApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Time Sink")
		end
	end
end

function mod:SandBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	sandBreathCount = sandBreathCount + 1
	-- pull:12.4, 20.6, 20.6, 18.2, 18.3, 20.6, 18.2, 18.2, 20.6, 18.2, 18.2
	if sandBreathCount == 2 or sandBreathCount % 3 == 0 then
		self:CDBar(args.spellId, 20.6)
	else
		self:CDBar(args.spellId, 18.2)
	end
end
