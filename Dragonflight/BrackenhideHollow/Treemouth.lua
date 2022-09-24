if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Treemouth", 2520, 2473)
if not mod then return end
mod:RegisterEnableMob(186120) -- Treemouth
mod:SetEncounterID(2568)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		376934, -- Grasping Vines
		378022, -- Consuming
		-- TODO Starving Rage (mythic only)
		376811, -- Decay Spray
		377859, -- Infectious Spit
		377559, -- Vine Whip
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GraspingVines", 376934)
	self:Log("SPELL_AURA_APPLIED", "ConsumingApplied", 378022)
	self:Log("SPELL_AURA_REMOVED", "ConsumingRemoved", 378022)
	-- TODO track partially digested debuff? (mythic only)
	self:Log("SPELL_CAST_START", "DecaySpray", 376811)
	self:Log("SPELL_CAST_SUCCESS", "InfectiousSpit", 377859)
	self:Log("SPELL_CAST_START", "VineWhip", 377559)
end

function mod:OnEngage()
	self:CDBar(377559, 5.7) -- Vine Whip
	self:Bar(376811, 13) -- Decay Spray
	self:Bar(376934, 16.6) -- Grasping Vines
	self:Bar(377859, 30) -- Infectious Spit
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GraspingVines(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 44.9)
end

do
	local consumingStart = 0

	function mod:ConsumingApplied(args)
		consumingStart = args.time
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "long", nil, args.destName)
	end

	function mod:ConsumingRemoved(args)
		local consumingDuration = args.time - consumingStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, consumingDuration))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prev = 0
	function mod:DecaySpray(args)
		-- bug? sometimes this gets double-cast, but only the second one succeeds
		local t = args.time
		if t - prev > 5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
		self:Bar(args.spellId, 20.6)
	end
end

function mod:InfectiousSpit(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 20.6)
end

function mod:VineWhip(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.4)
end
