-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Glubtok", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47162)
mod.toggleOptions = {
	"phase",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase"] = "Phases"
L["phase_desc"] = "Warn for phase changes."
L["phase_warning"] = "Phase 2 soon!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Deadmines/Glubtok", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 47162)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(_, unit)
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 53 then
			self:Message("phase", L["phase_warning"], "Positive")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

