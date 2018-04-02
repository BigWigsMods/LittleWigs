
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Rokmar the Crackler", 547, 571)
if not mod then return end
mod:RegisterEnableMob(17991)
-- mod.engageId = 1941 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34970, -- Frenzy
		31948, -- Ensnaring Moss
		38801, -- Grievous Wound
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 34970)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringMoss", 31948)
	self:Log("SPELL_AURA_REMOVED", "EnsnaringMossRemoved", 31948)
	self:Log("SPELL_AURA_APPLIED", "GrievousWound", 31956, 38801)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")

	self:Death("Win", 17991)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:Message(args.spellId, "Important", nil, CL.percent:format(20, args.spellName))
end

function mod:EnsnaringMoss(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:EnsnaringMossRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:GrievousWound(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(38801, args.destName, "Urgent")
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 17991 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 26 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			self:Message(34970, "Positive", nil, CL.soon:format(self:SpellName(34970)), false)
		end
	end
end

