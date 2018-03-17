-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Priestess Kilnara", 859, 181)
if not mod then return end
mod:RegisterEnableMob(52059)
mod.engageId = 1180
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		96435, -- Tears of Blood
		96423, -- Lash of Anguish
		96457, -- Wave of Agony
		-2702, -- Camouflage
		96592, -- Ravage
	}, {
		[96435] = CL.stage:format(1),
		[-2702] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TearsOfBlood", 96435)
	self:Log("SPELL_AURA_REMOVED", "TearsOfBloodRemoved", 96435)
	self:Log("SPELL_AURA_APPLIED", "LashOfAnguish", 96423)
	self:Log("SPELL_AURA_REMOVED", "LashOfAnguishRemoved", 96423)
	self:Log("SPELL_CAST_SUCCESS", "WaveOfAgony", 96457)

	self:Log("SPELL_AURA_APPLIED", "Ravage", 96592)
	self:Log("SPELL_AURA_APPLIED", "Camouflage", 96594)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:Message("stages", "Attention", "Info", CL.stage:format(1), false)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:TearsOfBlood(args)
	self:Message(args.spellId, "Important", "Alert")
	self:CastBar(args.spellId, 6)
end

function mod:TearsOfBloodRemoved(args)
	self:StopBar(CL.cast:format(args.spellName))
end

function mod:LashOfAnguish(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:LashOfAnguishRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:WaveOfAgony(args)
	self:Message(args.spellId, "Important")
	self:CDBar(args.spellId, 32)
end

function mod:Ravage(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:Camouflage()
	self:Message(-2702, "Important", "Alert")
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message("stages", "Attention", nil, CL.soon:format(CL.stage:format(2)), false)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, _, _, _, spellId)
	if spellId == 97380 then -- Cave In
		self:UnregisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", unit)
		self:Message("stages", "Attention", "Info", CL.stage:format(2), false)
	end
end
