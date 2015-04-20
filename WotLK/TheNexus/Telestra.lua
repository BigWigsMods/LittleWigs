
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Magus Telestra", 520, 618)
if not mod then return end
mod:RegisterEnableMob(26731)

local splitPhase = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-7395, -- Mirror Images
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")

	self:Death("Win", 26731)
end

function mod:OnEngage()
	splitPhase = 0
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 26731 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if (hp < 56 and splitPhase == 0) or (hp < 16 and splitPhase == 1) then
			splitPhase = splitPhase + 1
			if splitPhase > 1 then
				self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			end
			if splitPhase == 1 or (splitPhase == 2 and not self:Normal()) then -- No 2nd split on Normal mode
				self:Message(-7395, "Positive", nil, CL.soon:format(self:SpellName(-7395)), false)
			end
		end
	end
end

