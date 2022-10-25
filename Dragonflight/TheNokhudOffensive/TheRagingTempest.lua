--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Raging Tempest", 2516, 2497)
if not mod then return end
mod:RegisterEnableMob(186615) -- The Raging Tempest
mod:SetEncounterID(2636)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.on_you = "On you"
	L.on_boss = "On the boss"
end

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
	}, {
		[382628] = L.on_you,
		[394875] = L.on_boss,
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
	self:CDBar(384686, 7.3) -- Energy Surge
	self:CDBar(384316, 10.5) -- Lightning Strike
	self:CDBar(384620, 30.4) -- Electrical Storm
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
	-- stack maximum is 10, then APPLIED_DOSE doesn't fire anymore but REFRESH does
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
	self:CastBar(args.spellId, 18) -- 3s cast, 15s channel
	self:CDBar(args.spellId, 63.2) -- TODO guess, cast at 100 energy, 3s cast + 60s energy gain + ~.2s delay?
end

function mod:LightningStrike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8)
end

function mod:EnergySurge(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17)
	elseif self:Tank() or self:Healer() then
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
