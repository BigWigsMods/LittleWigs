
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("General Pa'valak", 1011, 692)
if not mod then return end
mod:RegisterEnableMob(61485)
mod.engageId = 1447
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextReinforcementsWarning = 70

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		124283, -- Blade Rush
		{119875, "HEALER"}, -- Tempest
		-5946, -- Call Reinforcements
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BladeRush", 124283)
	self:Log("SPELL_CAST_START", "Tempest", 119875)
	self:Log("SPELL_AURA_APPLIED", "ReinforcementsPhase", 119476) -- 119476 = Bulwark

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	nextReinforcementsWarning = 80 -- phases at 75% and 45%
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BladeRush(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 2)
end

function mod:Tempest(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
end

function mod:ReinforcementsPhase(args)
	self:Message(-5946, "Attention", "Info", CL.incoming:format(CL.adds), false)
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextReinforcementsWarning then
		self:Message(-5946, "Attention", nil, CL.soon:format(self:SpellName(-5946)))
		nextReinforcementsWarning = nextReinforcementsWarning - 30
		if nextReinforcementsWarning < 45 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end
