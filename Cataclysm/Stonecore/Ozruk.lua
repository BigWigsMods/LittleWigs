
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Ozruk", 725, 112)
if not mod then return end
mod:RegisterEnableMob(42188)
mod.engageId = 1058
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		78939, -- Elementium Bulwark
		78903, -- Ground Slam
		78807, -- Shatter
		80467, -- Enrage
		92426, -- Paralyze
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ElementiumBulwark", 78939)
	self:Log("SPELL_AURA_REMOVED", "ElementiumBulwarkRemoved", 78939)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 80467)
	self:Log("SPELL_CAST_START", "Paralyze", 92426)
	self:Log("SPELL_CAST_START", "Shatter", 78807)
	self:Log("SPELL_CAST_START", "GroundSlam", 78903)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(78807, 20) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ElementiumBulwark(args)
	if self:MobId(args.destGUID) == 42188 then -- we only warn if the boss gains it, not a mage spell stealing
		self:Message(args.spellId, "red", "Alarm")
		self:Bar(args.spellId, 10)
	end
end

function mod:ElementiumBulwarkRemoved(args)
	self:StopBar(args.spellName)
end

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	if self:MobId(UnitGUID(unit)) == 40586 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 27 then
			self:UnregisterUnitEvent(event, unit)
			self:Message(80467, "yellow", nil, CL.soon:format(self:SpellName(80467)), false)
		end
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "yellow")
end

function mod:Paralyze(args)
	self:Message(args.spellId, "red", "Alert", CL.other:format(args.spellName, CL.soon:format(self:SpellName(78807))))
end

function mod:Shatter(args)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
	self:Bar(args.spellId, 20)
end

function mod:GroundSlam(args)
	self:Message(args.spellId, "orange", "Alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

