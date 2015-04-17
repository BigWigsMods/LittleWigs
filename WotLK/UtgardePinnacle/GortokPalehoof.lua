-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Gortok Palehoof", 524)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(26687)
mod.toggleOptions = {
	48256, -- Roar
	48261, -- Impale
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["roarcooldown_bar"] = "Roar cooldown"--@end-do-not-package@
--@localization(locale="enUS", namespace="Howling_Fjord/Gortok_Palehoof", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_CAST_SUCCESS", "Roar", 48256, 59267)
	self:Log("SPELL_AURA_APPLIED", "Impale", 48261, 59268)
	self:Death("Win", 26687)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Roar(_, spellId, _, _, spellName)
	self:Message(48256, spellName, "Urgent", spellId)
	self:Bar(48256, L["roarcooldown_bar"], 10, spellId)
end

function mod:Impale(player, spellId, _, _, spellName)
	self:Message(48261, spellName..": "..player, "Attention", spellId)
end
