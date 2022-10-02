if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Raging Tempest", 2516, 2497)
if not mod then return end
mod:RegisterEnableMob(186615) -- The Raging Tempest
mod:SetEncounterID(2636)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		382628, -- Surge of Power (player version)
		394875, -- Surge of Power (boss version)
		384620, -- Electrical Storm
		384316, -- Lightning Strike
		{384686, "DISPEL"}, -- Energy Surge
	}, {
		[382628] = CL.general,
		[394875] = self.displayName,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SurgeOfPowerAppliedToPlayer", 382628)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SurgeOfPowerAppliedDoseToPlayer", 382628)
	self:Log("SPELL_AURA_REFRESH", "SurgeOfPowerRefreshOnPlayer", 382628)
	self:Log("SPELL_AURA_APPLIED", "SurgeOfPowerAppliedToBoss", 394875)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SurgeOfPowerAppliedToBoss", 394875)
	self:Log("SPELL_CAST_START", "ElectricalStorm", 384620)
	self:Log("SPELL_CAST_START", "LightningStrike", 384316)
	self:Log("SPELL_CAST_START", "EnergySurge", 384686)
	self:Log("SPELL_AURA_APPLIED", "EnergySurgeApplied", 384686)
	self:Log("SPELL_AURA_REMOVED", "EnergySurgeRemoved", 384686)
end

function mod:OnEngage()
	self:CDBar(384686, 8.1) -- Energy Surge
	self:CDBar(384316, 10.5) -- Lightning Strike
	self:Bar(384620, 31.2) -- Electrical Storm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SurgeOfPowerAppliedToPlayer(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, "blue", args.destName, 1, 1)
		self:PlaySound(args.spellId, "info")
		self:TargetBar(args.spellId, 15, args.destName)
	end
end

function mod:SurgeOfPowerAppliedDoseToPlayer(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:SurgeOfPowerRefreshOnPlayer(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 15, args.destName)
	end
end

function mod:SurgeOfPowerAppliedToBoss(args)
	-- Mythic only, happens when orbs reach the boss without being soaked
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "warning")
	self:TargetBar(args.spellId, 60, args.destName)
end

function mod:ElectricalStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 64.2) -- TODO guess, cast at 100 energy, 60s energy gain + 3s cast + ~1.2s delay?
end

function mod:LightningStrike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 38.9)
end

function mod:EnergySurge(args)
	if self:Dispeller("magic", true, args.spellId) or self:Tank() or self:Healer() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17)
	end
end

function mod:EnergySurgeApplied(args)
	if self:Dispeller("magic", true, args.spellId) or self:Tank() or self:Healer() then
		self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:EnergySurgeRemoved(args)
	if self:Dispeller("magic", true, args.spellId) or self:Tank() or self:Healer() then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end
