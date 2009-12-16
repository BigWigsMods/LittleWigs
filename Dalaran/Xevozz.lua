-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Xevozz", "The Violet Hold")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29266, 32231)
mod.toggleOptions = {
	54102, -- Summon Sphere
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["sphere_message"] = "Summoning Ethereal Sphere"--@end-do-not-package@
--@localization(locale="enUS", namespace="Dalaran/Xevozz", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Sphere", 54102, 54137, 54138, 61337, 61338)
	self:Death("Win", 29266, 32231)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Sphere(_, spellId)
	self:Message(54102, L["sphere_message"], "Important", spellId)
end
