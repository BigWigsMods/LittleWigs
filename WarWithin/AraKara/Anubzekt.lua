if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'zekt", 2660, 2584)
if not mod then return end
mod:RegisterEnableMob(215405) -- Anub'zekt
mod:SetEncounterID(2906)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Anub'zekt
		435012, -- Impale
		439506, -- Burrow Charge
		433740, -- Infestation
		433766, -- Eye of the Swarm
		-- Bloodstained Web Mage (Mythic)
		442210, -- Web Wrap
	}, {
		[435012] = self.displayName,
		[442210] = CL.extra:format(self:SpellName(-28975), CL.mythic), -- Bloodstained Webmage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Impale", 435012)
	self:Log("SPELL_CAST_START", "BurrowCharge", 439506)
	self:Log("SPELL_AURA_APPLIED", "Infestation", 433740)
	self:Log("SPELL_CAST_START", "EyeOfTheSwarm", 433766)
	self:Log("SPELL_AURA_APPLIED", "EyeOfTheSwarmApplied", 434408)
	self:Log("SPELL_AURA_REMOVED", "EyeOfTheSwarmOver", 434408)

	-- Bloodstained Webmage (Mythic)
	self:Log("SPELL_CAST_START", "WebWrap", 442210)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(435012, 4.8) -- Impale
	self:CDBar(439506, 14.5) -- Burrow Charge
	self:CDBar(433766, 29.1) -- Eye of the Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Impale(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 5.7)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(439506, "orange", name)
		self:PlaySound(439506, "alarm", nil, name)
	end

	function mod:BurrowCharge(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 66.8)
	end
end

function mod:Infestation(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 8.1)
end

function mod:EyeOfTheSwarm(args)
	self:SetStage(2)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 78.9)
	-- TODO could probably delay other bars a bit, Burrow Charge will not be cast soon either
end

function mod:EyeOfTheSwarmApplied(args)
	self:Bar(433766, 25, CL.onboss:format(args.spellName))
end

function mod:EyeOfTheSwarmOver(args)
	self:StopBar(CL.onboss:format(args.spellName))
	self:SetStage(1)
	self:Message(433766, "green", CL.over:format(args.spellName))
	self:PlaySound(433766, "info")
end

-- Bloodstained Webmage (Mythic)

function mod:WebWrap(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
