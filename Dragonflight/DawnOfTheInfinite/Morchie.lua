--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Morchie", 2579, 2536)
if not mod then return end
mod:RegisterEnableMob(
	198999, -- Morchie (Visage)
	202789  -- Morchie (Dragon)
)
mod:SetEncounterID(2671)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local sandBlastCount = 1
local moreProblemsCount = 1
local familiarFacesCount = 1
local timeTrapsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local moreProblemsMarker = mod:AddMarkerOption(true, "npc", 1, 403902, 1, 2, 3, 4, 5, 6) -- More Problems
function mod:GetOptions()
	return {
		-- Morchie
		404916, -- Sand Blast
		403891, -- More Problems!
		moreProblemsMarker,
		{404364, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Dragon's Breath
		405279, -- Familiar Faces
		406481, -- Time Traps
		{401667, "DISPEL"}, -- Time Stasis
		-- Familiar Face
		401200, -- Fixate
	}, {
		[404916] = self.displayName, -- Morchie
		[401200] = -26592, -- Familiar Face
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SandBlast", 404916)
	self:Log("SPELL_CAST_START", "MoreProblems", 403891)
	self:Log("SPELL_SUMMON", "MoreProblemsSummon", 403902)
	self:Log("SPELL_CAST_START", "DragonsBreath", 404364)
	self:Log("SPELL_CAST_START", "FamiliarFaces", 405279, 407504) -- initial summon, reactivation
	self:Log("SPELL_CAST_START", "TimeTraps", 406481)
	self:Log("SPELL_AURA_APPLIED", "TimeStasisApplied", 401667)
	self:Log("SPELL_AURA_APPLIED", "FixateApplied", 401200)
end

function mod:OnEngage()
	sandBlastCount = 1
	moreProblemsCount = 1
	familiarFacesCount = 1
	timeTrapsCount = 1
	self:CDBar(404916, 3.0) -- Sand Blast
	self:CDBar(403891, 10.0) -- More Problems!
	self:CDBar(406481, 36.0) -- Time Traps
	self:CDBar(405279, 43.0) -- Familiar Faces
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Morchie

function mod:SandBlast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	sandBlastCount = sandBlastCount + 1
	-- pull:3.0, 27.0, 20.0, 29.0, 12.0, 12.0, 12.0, 24.0, 12.0, 12.0, 12.0, 24.0
	if sandBlastCount == 2 then
		self:CDBar(args.spellId, 27.0)
	elseif sandBlastCount == 3 then
		self:CDBar(args.spellId, 20.0)
	elseif sandBlastCount == 4 then
		self:CDBar(args.spellId, 29.0)
	elseif sandBlastCount % 4 ~= 0 then -- 5, 6, 7, 9, 10, 11...
		self:CDBar(args.spellId, 12.0)
	else -- 8, 12...
		self:CDBar(args.spellId, 24.0)
	end
end

do
	local morchieCollector = {}
	local morchieCount = 1

	function mod:MoreProblems(args)
		if self:GetOption(moreProblemsMarker) then
			morchieCollector = {}
			morchieCount = 1
			self:RegisterTargetEvents("MorchieMarking")
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "long")
		moreProblemsCount = moreProblemsCount + 1
		-- pull:10.0, 50.0, 60.0, 60.0, 60.0
		if moreProblemsCount == 2 then
			self:CDBar(args.spellId, 50.0)
		else
			self:CDBar(args.spellId, 60.0)
		end
	end

	function mod:MoreProblemsSummon(args)
		if self:GetOption(moreProblemsMarker) then
			if not morchieCollector[args.destGUID] then
				morchieCollector[args.destGUID] = morchieCount
				morchieCount = morchieCount + 1
			end
		end
	end

	function mod:MorchieMarking(_, unit, guid)
		if morchieCollector[guid] then
			self:CustomIcon(moreProblemsMarker, unit, morchieCollector[guid])
			morchieCollector[guid] = nil
			if not next(morchieCollector) then
				self:UnregisterTargetEvents()
			end
		end
	end
end

do
	local prev = 0
	function mod:DragonsBreath(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
			self:CastBar(args.spellId, 8)
		end
	end
end

function mod:FamiliarFaces(args)
	self:Message(405279, "yellow")
	self:PlaySound(405279, "alert")
	familiarFacesCount = familiarFacesCount + 1
	-- first cast 405279 = pull:43.0
	-- reactivate 407504 = pull:96.0, 48.0, 24.0, 48.0, 48.0, 24.0, 48.0, 48.0
	if familiarFacesCount == 2 then
		self:CDBar(405279, 53.0)
	elseif familiarFacesCount % 3 == 1 then -- 4, 7, 10...
		self:CDBar(405279, 24.0)
	else -- 3, 5, 6, 8, 9...
		self:CDBar(405279, 48.0)
	end
end

function mod:TimeTraps(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
	timeTrapsCount = timeTrapsCount + 1
	-- pull:36.0, 48.0, 24.0, 48.0, 48.0, 24.0
	if timeTrapsCount % 3 == 0 then
		self:CDBar(args.spellId, 24.0)
	else
		self:CDBar(args.spellId, 48.0)
	end
end

function mod:TimeStasisApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, args.spellId) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Familiar Face

function mod:FixateApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
