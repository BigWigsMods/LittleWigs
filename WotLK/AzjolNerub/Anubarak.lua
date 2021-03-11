-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'arakAN", 601, 587) -- AN (Azjol-Nerub) is intentional to prevent conflict with Anub'arak from Trial of the Crusader
if not mod then return end
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
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_CAST_START", "Pound", 53472, 59433) -- normal, heroic
end

function mod:OnEngage()
	nextSubmergeWarning = 80 -- 75%, 50% and 25%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Pound(args)
	self:CastBar(53472, 3.2)
	self:MessageOld(53472, "yellow", "warning", CL.casting:format(args.spellName))
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	-- Submerge
	if UnitCanAttack("player", unit) then
		self:MessageOld(-6359, "cyan", nil, CL.over:format(self:SpellName(-6359)))
	else
		self:MessageOld(-6359, "cyan")
		self:Bar(-6359, self:Normal() and 41 or 62)
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextSubmergeWarning then
		self:MessageOld(-6359, "cyan", nil, CL.soon:format(self:SpellName(-6359))) -- Submerge
		nextSubmergeWarning = nextSubmergeWarning - 25

		while nextSubmergeWarning >= 25 and hp < nextSubmergeWarning do
			-- Account for high-level characters hitting multiple thresholds.
			-- Until at least one Submerge happens, the boss's health can't drop below 1.
			nextSubmergeWarning = nextSubmergeWarning - 25
		end

		if nextSubmergeWarning < 25 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
