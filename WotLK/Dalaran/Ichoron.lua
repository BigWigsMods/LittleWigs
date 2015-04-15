-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ichoron", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29313, 32234)
mod.toggleOptions = {
	54306, -- Bubble
	54312, -- Frenzy
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["bubbleEnded_message"] = "Protective Bubble Faded"
L["bubble_message"] = "Gained Protective Bubble"--@end-do-not-package@
--@localization(locale="enUS", namespace="Dalaran/Ichoron", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bubble", 54306)
	self:Log("SPELL_AURA_REMOVED", "BubbleRemoved", 54306)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 54312, 59522)
	self:Death("Win", 29313, 32234)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bubble(_, spellId)
	self:Message(54306, L["bubble_message"], "Important", spellId)
end

function mod:BubbleRemoved(_, spellId)
	self:Message(54306, L["bubbleEnded_message"], "Positive", spellId)
end

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(54312, spellName, "Important", spellId)
end
