
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Houndmaster Braun", 871, 660)
mod:RegisterEnableMob(59303)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"

	L.rage, L.rage_desc = EJ_GetSectionInfo(5611)
	L.rage_icon = 116140
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"rage", 114259, "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BloodyRage", 116140)
	self:Log("SPELL_CAST_SUCCESS", "CallDog", 114259)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59303)
end

function mod:OnEngage()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallDog(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId, "Alert")
end

function mod:BloodyRage(player, spellId, _, _, spellName)
	self:Message("rage", "50% - "..spellName, "Attention", spellId)
end

function mod:UNIT_HEALTH_FREQUENT(_, unitId)
	if unitId == "boss1" then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 55 then
			self:Message("rage", CL["soon"]:format((GetSpellInfo(116140))), "Positive", nil, "Info")
			self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		end
	end
end

