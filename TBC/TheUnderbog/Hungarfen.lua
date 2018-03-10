-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hungarfen", 726, 576)
if not mod then return end
mod:RegisterEnableMob(17770)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		31673, -- Foul Spores
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 17770)
end

function mod:OnEngage()
	if self:CheckOption(31673, "MESSAGE") then
		self:RegisterEvent("UNIT_HEALTH")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, unit)
	if UnitName(unit) ~= mod.displayName then return end
	local health = UnitHealth(unit) / UnitHealth(unit) * 100
	if health > 18 and health <= 24 then
		self:UnregisterEvent("UNIT_HEALTH")
		self:Message(31673, "Urgent", nil, CL.soon:format(self:SpellName(31673)))
	end
end
