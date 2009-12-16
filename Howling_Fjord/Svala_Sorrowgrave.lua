-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Svala Sorrowgrave", "Utgarde Pinnacle")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(26668)
mod.toggleOptions = {
	48276, -- Ritual
	48267, -- Preperation
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["ritualcooldown_bar"] = "Ritual cooldown"
L["ritualcooldown_message"] = "Ritual cooldown passed"--@end-do-not-package@
--@localization(locale="enUS", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Ritual", 48276)
	self:Log("SPELL_AURA_APPLIED", "Preparation", 48267)
	self:Death("Win", 26668)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Ritual(_, spellId, _, _, spellName)
	self:Message(48276, spellName, "Urgent", spellId)
	self:DelayedMessage(48276, 36, L["ritualcooldown_message"], "Attention")
	self:Bar(48276, spellName, 26, spellId)
	self:Bar(48276, L["ritualcooldown_bar"], 36, spellId)
end

function mod:Preparation(player, spellId, _, _, spellName)
	self:Message(48267, spellName..": "..player, "Attention", spellId)
end
