if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("HK-8 Aerial Oppression Unit", 2097, 2355)
if not mod then return end
mod:RegisterEnableMob(0) -- XXX add mob id
--mod.engageId = XXX

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		295536, -- Cannon Blast
		302274, -- Fulminating Zap
		{295445, "TANK_HEALER"}, -- Wreck
		296464, -- Reinforcement Relay
		296080, -- Haywire
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CannonBlast", 295536)
	self:Log("SPELL_AURA_APPLIED", "FulminatingZapApplied", 302274)
	self:Log("SPELL_CAST_SUCCESS", "Wreck", 295445)
	self:Log("SPELL_CAST_SUCCESS", "ReinforcementRelay", 296464)
	self:Log("SPELL_AURA_APPLIED", "HaywireApplied", 296080)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CannonBlast(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 3)
end

function mod:FulminatingZapApplied(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:Wreck(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ReinforcementRelay(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HaywireApplied(args)
	self:Message2(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:TargetBar(args.spellId, 30, args.destName)
end
