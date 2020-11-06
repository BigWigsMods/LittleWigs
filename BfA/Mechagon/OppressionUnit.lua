--------------------------------------------------------------------------------
-- TODO
-- Cannon Blast timer
--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("HK-8 Aerial Oppression Unit", 2097, 2355)
if not mod then return end
mod:RegisterEnableMob(150190, 150295) -- HK-8 Aerial Oppression Unit, Tank Buster MK1
mod.engageId = 2291

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		295536, -- Cannon Blast
		302274, -- Fulminating Zap
		{295445, "TANK_HEALER"}, -- Wreck
		301351, -- Reinforcement Relay
		296522, -- Self-Destruct
		296080, -- Haywire
		-- Hard Mode
		{303885, "SAY", "SAY_COUNTDOWN"}, -- Fulminating Burst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CannonBlast", 295536)
	self:Log("SPELL_AURA_APPLIED", "FulminatingZapApplied", 302274)
	self:Log("SPELL_CAST_SUCCESS", "Wreck", 295445)
	self:Log("SPELL_CAST_SUCCESS", "ReinforcementRelay", 301351)
	self:Log("SPELL_CAST_SUCCESS", "LiftOff", 301177)
	self:Log("SPELL_AURA_APPLIED", "HaywireApplied", 296080)
	self:Log("SPELL_CAST_START", "AnnihilationRay", 295939)
	self:Log("SPELL_AURA_APPLIED", "FulminatingBurstApplied", 303885)
	self:Log("SPELL_AURA_REMOVED", "FulminatingBurstRemoved", 303885)

	self:Death("TankBusterDeath", 150295)
end

function mod:OnEngage()
	self:CDBar(295445, 12) -- Wreck
	self:Bar(301351, 21.4) -- Reinforcement Relay
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TankBusterDeath(args)
	self:StopBar(301351) -- Reinforcement Relay
	self:StopBar(295445) -- Wreck
end

function mod:AnnihilationRay(args)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

function mod:CannonBlast(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 3)
end

function mod:FulminatingZapApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:Wreck(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 23)
end

function mod:ReinforcementRelay(args)
	self:Message(args.spellId, "orange", CL.spawning:format(CL.adds))
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 32.8)
	self:CDBar(296522, 15) -- Self-Destruct
end

function mod:LiftOff(args)
	self:Message("stages", "cyan", CL.stage:format(1), false)
	self:PlaySound("stages", "long")
	self:CDBar(295445, 20.5) -- Wreck
	self:Bar(301351, 31.5) -- Reinforcement Relay
end

function mod:HaywireApplied(args)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:TargetBar(args.spellId, 30, args.destName)
end

function mod:FulminatingBurstApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	self:TargetBar(args.spellId, 9)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId)
		self:YellCountdown(args.spellId, 9, nil, 5)
	end
end

function mod:FulminatingBurstRemoved(args)
	self:StopBar(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:CancelYellCountdown(args.spellId)
	end
end
