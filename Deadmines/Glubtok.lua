-- XXX Ulic: Any other suggestions

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Glubtok", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47162) -- XXX Possibly 42755 or 42492
mod.toggleOptions = {
	"phase",
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local p2 = nil

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

	self:Death("Win", 47162) -- XXX Possibly 42755 or 42492
end

function mod:OnEngage()
	p2 = nil
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(_, unit)
	if p2 then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 53 and not p2 then
			self:Message("phase", L["phase_warning"], "Positive")
			p2 = true
		end
	end
end
