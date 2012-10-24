
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Houndmaster Braun", 871, 660)
mod:RegisterEnableMob(59303)

local percent = 90

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_say = "Hmm, did you hear something lads?"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5611", 114259, "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BloodyRage", 116140)
	self:Log("SPELL_CAST_SUCCESS", "CallDog", 114259)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59303)
end

function mod:OnEngage()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	percent = 90
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallDog(_, spellId, _, _, spellName)
	self:Message(spellId, ("%d%% - %s"):format(percent, spellName), "Urgent", spellId, "Alert")
	percent = percent - 10
end

function mod:BloodyRage(player, spellId, _, _, spellName)
	self:Message("ej:5611", "50% - "..spellName, "Attention", spellId, "Alert")
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 55 then
			self:Message("ej:5611", CL["soon"]:format(self:SpellName(116140)), "Positive", nil, "Info") -- Bloody Rage
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end

