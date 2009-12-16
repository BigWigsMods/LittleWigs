-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("General Bjarngrim", "Halls of Lightning")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(28586)
mod.toggleOptions = {
	16856, --Mortal Strike
	41107, -- Berserker
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["berserker_applied"] = "Gained Berserker"
L["berserker_removed"] = "Berserker Fades"--@end-do-not-package@
--@localization(locale="enUS", namespace="Storm_Peaks/General_Bjarngrim", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalStrike", 16856)
	self:Log("SPELL_AURA_APPLIED", "Berserker", 41107)
	self:Log("SPELL_AURA_REMOVED", "BerserkerRemoved", 41107)
	self:Death("Win", 28586)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MortalStrike(player, spellId, _, _, spellName)
	self:Message(16856, spellName..": "..player, "Important", spellId)
	self:Bar(16856, player..": "..spellName, 5, spellId)
end

function mod:Berserker(_, spellId, _, _, _, _, _, _, dGuid)
	if tonumber(dGuid:sub(-12, -7), 16) ~= 28586 then return end
	self:Message(41107, L["berserker_applied"]:format(player), "Urgent", spellId)
end

function mod:BerserkerRemoved(_, spellId, _, _, _, _, _, _, dGuid)
	if tonumber(dGuid:sub(-12, -7), 16) ~= 28586 then return end
	self:Message(41107, L["berserker_removed"], "Attention", spellId)
end
