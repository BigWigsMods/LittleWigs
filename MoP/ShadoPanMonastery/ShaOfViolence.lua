
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Violence", 877, 685)
if not mod then return end
mod:RegisterEnableMob(56719)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "I will not be caged again. These Shado-Pan could not stop me. Neither shall you!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {-5813, 106872}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Enrage", 38166)
	self:Log("SPELL_AURA_REMOVED", "EnrageRemoved", 38166)
	self:Log("SPELL_AURA_APPLIED", "Smash", 106872)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 56719)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "EnrageSoon", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Smash(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", 34618)
	self:TargetBar(args.spellId, 4, args.destName, 34618)
	self:CDBar(args.spellId, 17, 34618) -- 17-19
end

function mod:Enrage(args)
	self:Message(-5813, "Important", "Long", args.spellId)
	self:Bar(-5813, 30, args.spellId)
end

function mod:EnrageRemoved(args)
	self:StopBar(args.spellName)
end

function mod:EnrageSoon(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 25 then
		self:Message(-5813, "Positive", "Info", CL["soon"]:format(self:SpellName(38166)), false) -- Enrage
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
	end
end

