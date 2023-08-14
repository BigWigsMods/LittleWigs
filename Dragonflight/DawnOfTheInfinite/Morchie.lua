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

--------------------------------------------------------------------------------
-- Initialization
--

local moreProblemsMarker = mod:AddMarkerOption(true, "npc", 1, 403902, 1, 2, 3, 4, 5, 6) -- More Problems
function mod:GetOptions()
	return {
		404916, -- Sand Blast
		403891, -- More Problems!
		moreProblemsMarker,
		{404364, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Dragon's Breath
		405279, -- Familiar Faces
		406481, -- Time Traps
		{401667, "DISPEL"}, -- Time Stasis
		-- TODO 412769 Anachronistic Decay (fixate) damage near you?
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
end

function mod:OnEngage()
	sandBlastCount = 1
	moreProblemsCount = 1
	familiarFacesCount = 1
	self:CDBar(404916, 4.8) -- Sand Blast
	self:CDBar(403891, 10.1) -- More Problems!
	self:CDBar(406481, 30.3) -- Time Traps
	self:CDBar(405279, 38.5) -- Familiar Faces
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SandBlast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	sandBlastCount = sandBlastCount + 1
	-- pull:4.8, 38.8, 29.2, 21.9, 29.1
	if sandBlastCount == 2 then
		self:CDBar(args.spellId, 38.8)
	elseif sandBlastCount % 2 == 1 then
		self:CDBar(args.spellId, 29.1)
	else
		self:CDBar(args.spellId, 21.8)
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
		-- pull:10.1, 40.0, 47.4, 51.1, 52.2, 51.0, 51.0
		if moreProblemsCount == 2 then
			self:CDBar(args.spellId, 39.7)
		elseif moreProblemsCount == 3 then
			self:CDBar(args.spellId, 47.4)
		else
			self:CDBar(args.spellId, 51.0)
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
	-- first cast 405279 = pull:38.8
	-- reactivate 407504 = pull:68.2, 20.6, 29.2, 21.9, 29.2, 21.9, 29.1, 21.8, 29.1, 23.1, 29.1
	if familiarFacesCount == 2 then
		self:CDBar(405279, 30.4)
	elseif familiarFacesCount == 3 then
		self:CDBar(405279, 20.6)
	elseif familiarFacesCount % 2 == 0 then
		self:CDBar(405279, 29.1)
	else
		self:CDBar(405279, 21.8)
	end
end

function mod:TimeTraps(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 50.9)
end

function mod:TimeStasisApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, args.spellId) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
