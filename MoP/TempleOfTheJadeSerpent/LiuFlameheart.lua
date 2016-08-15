
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Liu Flameheart", 867, 658)
if not mod then return end
mod:RegisterEnableMob(56732)

--------------------------------------------------------------------------------
-- Locals
--

local smash = mod:SpellName(34618)

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

	self:Death("Win", 56732)
end

function mod:OnEngage()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	self:Bar(106872, "~"..smash, 17, 106872) -- 17-19
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Smash(player, spellId)
	self:TargetMessage(spellId, smash, player, "Urgent", spellId, "Alarm")
	self:Bar(spellId, CL["other"]:format(smash, player), 4, spellId)
	self:Bar(spellId, "~"..smash, 17, spellId) -- 17-19
end

function mod:Enrage(_, spellId, _, _, spellName)
	self:Message(-5813, spellName, "Important", spellId, "Long")
	self:Bar(-5813, spellName, 30, spellId)
end

function mod:EnrageRemoved(_, _, _, _, spellName)
	self:StopBar(spellName)
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 25 then
			self:Message(-5813, CL["soon"]:format(self:SpellName(38166)), "Positive", 38166, "Info") -- Enrage
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end
