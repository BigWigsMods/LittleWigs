-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'arakAN", 533, 587) -- AN (AnzolNerub) is intentional to prevent conflict with Anub'arak from The Coliseum
if not mod then return end
mod.displayName = "Anub'arak"
mod:RegisterEnableMob(29120)
mod.engageId = 1973
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Locals
--

local nextSubmergeWarning = 80

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		53472, -- Pound
		-6359, -- Submerge
	}
end

function mod:OnBossEnable()
	local nextSubmergeWarning = 80 -- 75%, 50% and 25%
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_CAST_START", "Pound", 53472, 59433) -- normal, heroic
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Pound(args)
	self:CastBar(53472, 3.2)
	self:Message(53472, "Attention", nil, CL.casting:format(args.spellName))
end

function mod:UNIT_TARGETABLE_CHANGED(unit)
	if UnitCanAttack("player", unit) then
		self:Message(-6359, "Neutral", nil, CL.over:format(self:SpellName(-6359)))
	else
		self:Message(-6359, "Neutral")
		self:Bar(-6359, self:Normal() and 41 or 62)
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextSubmergeWarning then
		self:Message(-6359, "Neutral", nil, CL.soon:format(self:SpellName(-6359)))
		nextSubmergeWarning = nextSubmergeWarning - 25

		while nextSubmergeWarning >= 25 and hp < nextSubmergeWarning do
			-- Account for high-level characters hitting multiple thresholds.
			-- Until at least one Submerge happens, the boss's health can't drop below 1.
			nextSubmergeWarning = nextSubmergeWarning - 25
		end

		if nextSubmergeWarning < 25 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end
