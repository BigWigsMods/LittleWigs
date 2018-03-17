-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Isiset", 644, 127)
if not mod then return end
mod:RegisterEnableMob(39587)

--------------------------------------------------------------------------------
-- Locals
--

local split1 = nil

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		74373, -- Veil of Sky
		74137, -- Supernova
		-2556, -- Mirror Images
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "VeilOfSky", 74133, 74372, 74373)
	self:Log("SPELL_AURA_REMOVED", "VeilOfSkyRemoved", 74133, 74372, 74373)
	self:Log("SPELL_CAST_START", "Supernova", 74136, 74137, 76670)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 39587)
end

function mod:OnEngage()
	split1 = nil
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:VeilOfSky(args)
	self:Message(74373, "Attention")
	self:CDBar(74373, 60)
end

function mod:VeilOfSkyRemoved(args)
	self:StopBar(74373)
end

function mod:Supernova(args)
	self:Message(74137, "Important", "Alert", CL.casting:format(args.spellName))
	self:CastBar(74137, 3)
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 72 and not split1 then
			self:Message(-2556, "Attention", nil, CL.soon:format(self:SpellName(-2556)))
			split1 = true
		elseif hp < 39 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
			self:Message(-2556, "Attention", nil, CL.soon:format(self:SpellName(-2556)))
		end
	end
end
