
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Ashbury", 33, 96)
if not mod then return end
mod:RegisterEnableMob(46962)
mod.engageId = 1069
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93581, -- Pain and Suffering
		93423, -- Asphyxiate
		93757, -- Dark Archangel Form
	}, {
		[93581] = "general",
		[93757] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PainAndSuffering", 93581)
	self:Log("SPELL_CAST_SUCCESS", "Asphyxiate", 93423)
	self:Log("SPELL_CAST_START", "DarkArchangelForm", 93757)
end

function mod:OnEngage()
	self:CDBar(93423, self:Heroic() and 20.6 or 15.5) -- Asphyxiate
	if self:Heroic() then -- Dark Archangel Form is heroic-only
		self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:PainAndSuffering(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
end

function mod:Asphyxiate(args)
	self:Message(args.spellId, "Important")
	self:CDBar(args.spellId, self:Heroic() and 40 or 35.7)
	self:CastBar(args.spellId, 6)
end

function mod:DarkArchangelForm(args)
	self:Message(args.spellId, "Attention", "Long")
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 25 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(93757, "Attention", nil, CL.soon:format(self:SpellName(93757)), false)
	end
end
