--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chrono-Lord Deios", 2451, 2479)
if not mod then return end
mod:RegisterEnableMob(184125) -- Chrono-Lord Deios
mod:SetEncounterID(2559)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local rewindTimeflowCount = 0
local wingBuffetCount = 0
local sandBreathCount = 0

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
	self:Log("SPELL_CAST_SUCCESS", "RewindTimeflowStart", 376208)
	self:Log("SPELL_AURA_REMOVED", "RewindTimeflowOver", 376208)
	self:Log("SPELL_CAST_START", "WingBuffet", 376049)
	self:Log("SPELL_AURA_APPLIED", "TimeSinkApplied", 377405)
	self:Log("SPELL_CAST_START", "SandBreath", 375727)
end

function mod:OnEngage()
	rewindTimeflowCount = 0
	wingBuffetCount = 0
	sandBreathCount = 0
	self:CDBar(377405, 5.0) -- Time Sink
	self:CDBar(376049, 6.0) -- Wing Buffet
	self:CDBar(375727, 12.1) -- Sand Breath
	self:CDBar(376208, 25.3, CL.count:format(self:SpellName(376208), 1)) -- Rewind Timeflow (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 16.9, CL.active, "achievement_dungeon_uldaman")
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
	rewindTimeflowCount = rewindTimeflowCount + 1
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, rewindTimeflowCount))
	self:PlaySound(args.spellId, "long")
	self:StopBar(CL.count:format(args.spellName, rewindTimeflowCount))
	self:Bar(args.spellId, 42.4, CL.count:format(args.spellName, rewindTimeflowCount + 1))
end

function mod:RewindTimeflowStart(args)
	self:CastBar(args.spellId, 12)
end

function mod:RewindTimeflowOver(args)
	self:Message(args.spellId, "yellow", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:WingBuffet(args)
	wingBuffetCount = wingBuffetCount + 1
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if wingBuffetCount == 1 then
		self:Bar(args.spellId, 37.5)
	else
		self:Bar(args.spellId, 42.4)
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:TimeSinkApplied(args)
		local t = args.time
		if t - prev > 3 then -- detect new round of debuffs, no SPELL_CAST_SUCCESS
			prev = t
			playerList = {}
			self:CDBar(args.spellId, 42.4)
		end
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 3)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end
end

function mod:SandBreath(args)
	sandBreathCount = sandBreathCount + 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if sandBreathCount == 1 then
		self:Bar(args.spellId, 27.8)
	elseif sandBreathCount % 2 == 0 then
		self:Bar(args.spellId, 18.2)
	else
		self:Bar(args.spellId, 24.2)
	end
end
