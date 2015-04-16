-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grandmaster Vorpil", 724, 546)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18732)
mod.toggleOptions = {
	{38791, "ICON"},
	"teleport",
	"bosskill",
}
mod.optionHeaders = {
	[38791] = "heroic",
	teleport = "general",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Grandmaster Vorpil", "enUS", true)
if L then
	--@do-not-package@
	L["teleport"] = "Teleport"
	L["teleport_desc"] = "Warning for when Grandmaster Vorpil will Teleport."
	L["teleport_message"] = "Teleport!"
	L["teleport_warning"] = "Teleport in ~5sec!"
	L["teleport_bar"] = "~Teleport"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Auchindoun/Blackheart", format="lua_additive_table", handle-unlocalized="ignore")@
end

L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Grandmaster Vorpil")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Teleport", 33563)
	self:Log("SPELL_AURA_APPLIED", "Banish", 38791)
	self:Death("Win", 18732)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	self:Bar(33563, L["teleport_bar"], 40, 33563)
	self:DelayedMessage(33563, 35, L["teleport_warning"], "Attention", nil, nil, nil, 33563)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Teleport()
	self:Message(33563, L["teleport_message"], "Urgent", 33563)
	self:Bar(33563, L["teleport_bar"], 37, 33563)
	self:DelayedMessage(33563, 32, L["teleport_warning"], "Attention")
end

function mod:Banish(player, spellId, _, _, spellName)
	self:Message(38791, spellName..": "..player, "Important", spellId)
	self:Bar(38791, player..": "..spellName, 8, spellId) 
end
