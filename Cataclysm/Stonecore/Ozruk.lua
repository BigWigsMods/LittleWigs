
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

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(78807, 20) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ElementiumBulwark(args)
	if self:MobId(args.destGUID) == 42188 then -- we only warn if the boss gains it, not a mage spell stealing
		self:MessageOld(args.spellId, "red", "alarm")
		self:Bar(args.spellId, 10)
	end
end

function mod:ElementiumBulwarkRemoved(args)
	self:StopBar(args.spellName)
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 27 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(80467, "yellow", nil, CL.soon:format(self:SpellName(80467)), false)
	end
end

function mod:Enrage(args)
	self:MessageOld(args.spellId, "yellow")
end

function mod:Paralyze(args)
	self:MessageOld(args.spellId, "red", "alert", CL.other:format(args.spellName, CL.soon:format(self:SpellName(78807))))
end

function mod:Shatter(args)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
	self:Bar(args.spellId, 20)
end

function mod:GroundSlam(args)
	self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

