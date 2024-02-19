--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Treemouth", 2520, 2473)
if not mod then return end
mod:RegisterEnableMob(186120) -- Treemouth
mod:SetEncounterID(2568)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local graspingVinesCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		376934, -- Grasping Vines
		378022, -- Consuming
		{376811, "SAY"}, -- Decay Spray
		377859, -- Infectious Spit
		377559, -- Vine Whip
		-- Decaying Slime
		378054, -- Withering Away!
		-- Mythic
		383875, -- Partially Digested
		390968, -- Starving Frenzy
	}, {
		[378054] = -25302, -- Decaying Slime
		[383875] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GraspingVines", 376934)
	self:Log("SPELL_AURA_APPLIED", "ConsumingStart", 378022)
	self:Log("SPELL_AURA_APPLIED", "ConsumingApplied", 377222)
	self:Log("SPELL_AURA_REMOVED", "ConsumingRemoved", 378022)
	self:Log("SPELL_CAST_START", "DecaySpray", 376811)
	-- Infectious Spit is only cast in non-Mythic difficulties as of 2023-05-13
	self:Log("SPELL_CAST_SUCCESS", "InfectiousSpit", 377859)
	self:Log("SPELL_CAST_START", "VineWhip", 377559)

	-- Decaying Slime
	self:Log("SPELL_AURA_APPLIED", "WitheringAwayDamage", 378054)
	self:Log("SPELL_PERIODIC_DAMAGE", "WitheringAwayDamage", 378054)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "PartiallyDigestedApplied", 383875)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PartiallyDigestedApplied", 383875)
	self:Log("SPELL_CAST_SUCCESS", "StarvingFrenzy", 390968)
end

function mod:OnEngage()
	graspingVinesCount = 1
	self:CDBar(377559, 5.0) -- Vine Whip
	self:CDBar(376811, 12.1) -- Decay Spray
	if not self:Mythic() then
		self:CDBar(377859, 20.9) -- Infectious Spit
	end
	-- 23s energy gain + .2s delay
	self:CDBar(376934, 23.2, CL.count:format(self:SpellName(376934), graspingVinesCount)) -- Grasping Vines
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GraspingVines(args)
	self:StopBar(CL.count:format(args.spellName, graspingVinesCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, graspingVinesCount))
	self:PlaySound(args.spellId, "info")
	graspingVinesCount = graspingVinesCount + 1
	-- 5s cast + 4s channel before Consume + 45s energy gain + .5s delay
	self:CDBar(args.spellId, 54.5, CL.count:format(args.spellName, graspingVinesCount))
	-- takes 10s to fully cast + .2 delay
	if self:BarTimeLeft(376811) < 10.2 then -- Decay Spray
		self:CDBar(376811, {10.2, 42.5})
	end
	if not self:Mythic() and self:BarTimeLeft(377859) < 10.2 then -- Infectious Spit
		self:CDBar(377859, {10.2, 20.6})
	end
	if self:BarTimeLeft(377559) < 10.2 then -- Vine Whip
		self:CDBar(377559, {10.2, 15.8})
	end
end

do
	local consumingStart = 0
	local playerList = {}

	function mod:ConsumingStart(args)
		consumingStart = args.time
		playerList = {}
	end

	function mod:ConsumingApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(378022, "red", playerList, 5, nil, nil, .1)
		self:PlaySound(378022, "long", nil, playerList)
	end

	function mod:ConsumingRemoved(args)
		local consumingDuration = args.time - consumingStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, consumingDuration))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(376811, "yellow", name)
		self:PlaySound(376811, "alert", nil, name)
		if self:Me(guid) then
			self:Say(376811, nil, nil, "Decay Spray")
		end
	end

	local prev = 0
	function mod:DecaySpray(args)
		-- bugged, often this starts cast multiple times, but only the last one succeeds
		local t = args.time
		if t - prev > 5 then
			prev = t
			self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		end
		self:CDBar(args.spellId, 42.5)
		-- Treemouth won't cast other abilities for 8.3 seconds after Decay Spray
		if not self:Mythic() and self:BarTimeLeft(377859) < 8.3 then -- Infectious Spit
			self:CDBar(377859, {8.3, 20.6})
		end
		if self:BarTimeLeft(377559) < 8.3 then -- Vine Whip
			self:CDBar(377559, {8.3, 15.8})
		end
	end
end

function mod:InfectiousSpit(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.6)
	-- Treemouth won't cast other abilities for 3.63 seconds after Infectious Spit
	if self:BarTimeLeft(376811) < 3.63 then -- Decay Spray
		self:CDBar(376811, {3.63, 42.5})
	end
	if self:BarTimeLeft(377559) < 3.63 then -- Vine Whip
		self:CDBar(377559, {3.63, 15.8})
	end
end

do
	local prev = 0
	function mod:VineWhip(args)
		-- bugged, often this starts cast multiple times, but only the last one succeeds
		local t = args.time
		if t - prev > 5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		self:CDBar(args.spellId, 15.8)
		-- Treemouth won't cast other abilities for 4.85 seconds after Vine Whip
		if self:BarTimeLeft(376811) < 4.85 then -- Decay Spray
			self:CDBar(376811, {4.85, 42.5})
		end
		if not self:Mythic() and self:BarTimeLeft(377859) < 4.85 then -- Infectious Spit
			self:CDBar(377859, {4.85, 20.6})
		end
	end
end

-- Decaying Slime

do
	local prev = 0
	function mod:WitheringAwayDamage(args)
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

-- Mythic

function mod:PartiallyDigestedApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
		self:TargetBar(args.spellId, 60, args.destName)
	end
end

function mod:StarvingFrenzy(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
