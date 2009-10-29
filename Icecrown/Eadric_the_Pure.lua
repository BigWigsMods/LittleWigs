-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Eadric the Pure", "Trial of the Champion")
if not mod then return end
mod.partycontent = true
mod:RegisterEnableMob(35119)
mod.toggleOptions = {
	66935, -- Radiance
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Eadric the Pure", "enUS", true)
if L then
	--@do-not-package@
	L["defeat_trigger"] = "I yield! I submit. Excellent work. May I run away now?"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Icecrown/Eadric_the_Pure", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Eadric the Pure")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "radiance", 66935, 66862, 67681)

	self:Yell("Win", L["defeat_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:radiance(_, spellId, _, _, spellName)
	self:Message(66935, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(66935, spellName, 3, spellId)
end
