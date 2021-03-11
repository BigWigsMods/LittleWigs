
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Lady Naz'jar", 643, 101)
if not mod then return end
mod:RegisterEnableMob(40586)
mod.engageId = 1045
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextSpoutWarning = 66

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		75683, -- Waterspout
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "Waterspout", 75683)
	self:Log("SPELL_AURA_REMOVED", "WaterspoutRemoved", 75683)
end

function mod:OnEngage()
	nextSpoutWarning = 66
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Waterspout(args)
	self:Bar(args.spellId, 60)
end

function mod:WaterspoutRemoved(args) -- if all 3 adds die, she stops casting
	self:StopBar(args.spellId)
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextSpoutWarning then
		self:MessageOld(75683, "yellow", nil, CL.soon:format(self:SpellName(75683)), false)
		nextSpoutWarning = nextSpoutWarning - 30
		if nextSpoutWarning < 36 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

