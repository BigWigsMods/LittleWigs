-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hungarfen", 726, 576)
if not mod then return end
mod:RegisterEnableMob(17770)
-- mod.engageId = 1946 -- doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		31673, -- Foul Spores
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealth(unit) * 100
	if hp < 25 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(31673, "Urgent", nil, CL.soon:format(self:SpellName(31673)))
	end
end
