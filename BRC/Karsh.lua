-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Karsh Steelbender", 753)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39698)
mod.toggleOptions = {
	75842, -- Quicksilver Armor
	93567, -- Superheated Quicksilver Armor
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then--@do-not-package@
L["weakened"] = "Weakened"
L["strengthened"] = "Strengthened"--@end-do-not-package@
--@localization(locale="enUS", namespace="BRC/Karsh", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Armor", 75842)
	self:Log("SPELL_AURA_APPLIED", "HeatedArmor", 75846, 93567)

	self:Death("Win", 39698)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Armor()
	self:Message(75842, L["strengthened"], "Attention", 28059, "Alert") --icon = spell_chargepositive
end

function mod:HeatedArmor()
	self:Message(93567, L["weakened"], "Important", 28084, "Info") --icon = spell_chargenegative
end

