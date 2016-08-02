
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Kael'thas Sunstrider ", 798, 533) -- Space is intentional to prevent conflict with Kael'thas from Tempest Keep/The Eye
if not mod then return end
mod:RegisterEnableMob(24664)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		44224, -- Gravity Lapse
		44194, -- Phoenix
		44192, -- Flame Strike
		46165, -- Shock Barrier
		36819, -- Pyroblast
	}, {
		[44224] = "general",
		[46165] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_CAST_START", "GravityLapse", 44224)
	self:Log("SPELL_CAST_START", "Pyroblast", 36819)
	self:Log("SPELL_SUMMON", "Phoenix", 44194)
	self:Log("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:Log("SPELL_AURA_APPLIED", "ShockBarrier", 46165)
	self:Death("Win", 24664)
end

function mod:OnEngage()
	self:CDBar(46165, 60) -- Shock Barrier
	self:DelayedMessage(46165, 50, "Attention", CL.soon:format(self:SpellName(46165)))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 24664 then -- Kael'thas Sunstrider
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 52 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			self:CancelDelayedMessage(CL.soon:format(self:SpellName(46165)))
			self:Message(44224, "Positive", nil, CL.soon:format(self:SpellName(44224)), false)
		end
	end
end

function mod:GravityLapse(args)
	self:Bar(args.spellId, 35)
end

function mod:Phoenix(args)
	self:Message(args.spellId, "Urgent")
end

function mod:FlameStrike(args)
	self:Message(44192, "Important")
end

function mod:ShockBarrier(args)
	self:Message(args.spellId, "Attention")
end

function mod:Pyroblast(args)
	self:Bar(args.spellId, 4)
	self:Message(args.spellId, "Important", "Info", CL.casting:format(args.spellName))
end

