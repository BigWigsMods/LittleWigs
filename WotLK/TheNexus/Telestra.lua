
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Magus Telestra", 576, 618)
if not mod then return end
mod:RegisterEnableMob(26731)
mod.engageId = 2010

--------------------------------------------------------------------------------
-- Locals
--

local splitPhase = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-7395, -- Mirror Images
		47731, -- Critter
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Critter", 47731)
end

function mod:OnEngage()
	splitPhase = 0
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if (hp < 56 and splitPhase == 0) or (hp < 16 and splitPhase == 1) then
		splitPhase = splitPhase + 1
		if splitPhase > 1 or self:Normal() then -- No 2nd split on Normal mode
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
		end
		self:Message(-7395, "Positive", nil, CL.soon:format(self:SpellName(-7395)), false)
	end
end

do
	local playerList = mod:NewTargetList()

	function mod:Critter(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
		end
	end
end
