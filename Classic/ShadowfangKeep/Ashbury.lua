
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Ashbury", nil, 96, 33)
if not mod then return end
mod:RegisterEnableMob(46962)
mod.engageId = 1069

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93581, -- Pain and Suffering
		93423, -- Asphyxiate
		93757, -- Dark Archangel Form
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PainAndSuffering", 93581)
	self:Log("SPELL_CAST_SUCCESS", "Asphyxiate", 93423)
	self:Log("SPELL_CAST_START", "Archangel", 93757)
end

--[[function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end]]

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:PainAndSuffering(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
end

function mod:Asphyxiate(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 40)
end

function mod:Archangel(args)
	self:Message(args.spellId, "Attention", "Long")
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 25 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(93757, "Attention", nil, CL.soon:format(self:SpellName(93757)), false)
	end
end
