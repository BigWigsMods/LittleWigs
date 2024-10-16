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
-- Locals
--

local fortifiedShellCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local crystalShardMarker = mod:AddMarkerOption(true, "npc", 8, 422261, 8, 7, 6) -- Crystal Shard
function mod:GetOptions()
	return {
		422233, -- Crystalline Smash
		crystalShardMarker,
		423200, -- Fortified Shell
		423538, -- Unstable Crash
		-- Mythic
		423572, -- Unstable Energy
	}, {
		[423572] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrystallineSmash", 422233)
	self:Log("SPELL_CAST_SUCCESS", "CrystallineSmashSuccess", 422233)
	self:Log("SPELL_SUMMON", "CrystalShardSummon", 422261)
	self:Log("SPELL_CAST_START", "FortifiedShell", 423200)
	self:Log("SPELL_AURA_APPLIED", "FortifiedShellApplied", 423228)
	self:Log("SPELL_AURA_REMOVED", "FortifiedShellRemoved", 423228)
	self:Log("SPELL_CAST_START", "UnstableCrash", 423538)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "UnstableEnergyApplied", 423572)
	self:Log("SPELL_AURA_APPLIED_DOSE", "UnstableEnergyApplied", 423572)
	self:Log("SPELL_AURA_REFRESH", "UnstableEnergyRefresh", 423572)
	self:Log("SPELL_AURA_REMOVED", "UnstableEnergyRemoved", 423572)
end

function mod:OnEngage()
	fortifiedShellCount = 1
	self:SetStage(1)
	self:CDBar(422233, 4.5) -- Crystalline Smash
	self:CDBar(423538, 10.6) -- Unstable Crash
	self:CDBar(423200, 37.5, CL.count:format(self:SpellName(423200), fortifiedShellCount)) -- Fortified Shell
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrystallineSmash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

do
	local crystalShardCollector = {}
	local crystalShardCount = 1

	function mod:CrystallineSmashSuccess()
		if self:GetOption(crystalShardMarker) then
			crystalShardCollector = {}
			crystalShardCount = 1
			self:RegisterTargetEvents("MarkCrystalShard")
		end
	end

	function mod:CrystalShardSummon(args)
		if self:GetOption(crystalShardMarker) then
			if not crystalShardCollector[args.destGUID] then
				crystalShardCollector[args.destGUID] = 9 - crystalShardCount -- 8, 7, 6
				crystalShardCount = crystalShardCount + 1
			end
		end
	end

	function mod:MarkCrystalShard(_, unit, guid)
		if crystalShardCollector[guid] then
			self:CustomIcon(crystalShardMarker, unit, crystalShardCollector[guid])
			crystalShardCollector[guid] = nil
			if not next(crystalShardCollector) then
				self:UnregisterTargetEvents()
			end
		end
	end
end

function mod:FortifiedShell(args)
	self:StopBar(422233) -- Crystalline Smash
	self:StopBar(423538) -- Unstable Crash
	self:StopBar(CL.count:format(args.spellName, fortifiedShellCount))
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, fortifiedShellCount))
	self:PlaySound(args.spellId, "long")
	fortifiedShellCount = fortifiedShellCount + 1
end

do
	local fortifiedShellStart = 0

	function mod:FortifiedShellApplied(args)
		fortifiedShellStart = args.time
	end

	function mod:FortifiedShellRemoved(args)
		self:SetStage(1)
		self:Message(423200, "green", CL.removed_after:format(args.spellName, args.time - fortifiedShellStart)) -- Fortified Shell
		self:CDBar(422233, 10.0) -- Crystalline Smash
		self:CDBar(423538, 16.1) -- Unstable Crash
		self:CDBar(423200, 42.8, CL.count:format(self:SpellName(423200), fortifiedShellCount)) -- Fortified Shell
		self:PlaySound(423200, "info") -- Fortified Shell
	end
end

function mod:UnstableCrash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "alarm")
end

-- Mythic

function mod:UnstableEnergyApplied(args)
	if self:Me(args.destGUID) then
		-- not using StackMessage in order to preserve message color, since alerts are just for the player
		self:Message(args.spellId, "green", CL.stackyou:format(args.amount or 1, args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:UnstableEnergyRefresh(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:UnstableEnergyRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellName, args.destName)
	end
end
