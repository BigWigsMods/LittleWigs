if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skarmorak", 2652, 2579)
if not mod then return end
mod:RegisterEnableMob(210156) -- Skarmorak
mod:SetEncounterID(2880)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		422233, -- Crystalline Smash
		423200, -- Reclaim
		423228, -- Crumbling Shell
		423538, -- Unstable Crash
		423572, -- Void Empowerment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrystallineSmash", 422233)
	self:Log("SPELL_CAST_START", "Reclaim", 423200)
	self:Log("SPELL_AURA_APPLIED", "CrumblingShellApplied", 423228)
	self:Log("SPELL_AURA_REMOVED", "CrumblingShellRemoved", 423228)
	self:Log("SPELL_CAST_START", "UnstableCrash", 423538)
	self:Log("SPELL_AURA_APPLIED", "VoidEmpowermentApplied", 423572)
	self:Log("SPELL_AURA_APPLIED_DOSE", "VoidEmpowermentApplied", 423572)
	self:Log("SPELL_AURA_REFRESH", "VoidEmpowermentRefresh", 423572)
	self:Log("SPELL_AURA_REMOVED", "VoidEmpowermentRemoved", 423572)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(422233, 3.9) -- Crystalline Smash
	self:CDBar(423538, 10.9) -- Unstable Crash
	self:CDBar(423200, 37.5) -- Reclaim
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrystallineSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0)
end

function mod:Reclaim(args)
	self:StopBar(422233) -- Crystalline Smash
	self:StopBar(423538) -- Unstable Crash
	self:StopBar(args.spellId)
	self:SetStage(2)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

do
	local crumblingShellStart = 0

	function mod:CrumblingShellApplied(args)
		crumblingShellStart = args.time
	end

	function mod:CrumblingShellRemoved(args)
		local crumblingShellDuration = args.time - crumblingShellStart
		self:SetStage(1)
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, crumblingShellDuration))
		self:PlaySound(args.spellId, "info")
		self:CDBar(422233, 6.9) -- Crystalline Smash
		self:CDBar(423538, 14.2) -- Unstable Crash
		self:CDBar(423200, 40.9) -- Reclaim
	end
end

function mod:UnstableCrash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 19.4)
end

function mod:VoidEmpowermentApplied(args)
	if self:Me(args.destGUID) then
		-- not using StackMessage in order to preserve message color, since alerts are just for the player
		self:Message(args.spellId, "green", CL.stackyou:format(args.amount or 1, args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:VoidEmpowermentRefresh(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:VoidEmpowermentRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellName, args.destName)
	end
end
