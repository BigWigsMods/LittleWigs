-------------------------------------------------------------------------------
--  Module Declaration 

-- "Portals" isn't going to work, gonna have to rethink that
local mod = BigWigs:NewBoss("Portals", "The Violet Hold")
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(30658)
mod.toggleOptions = {"portals", "bosskill"}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: The Violet Hold", "enUS", true)
if L then
--@do-not-package@
L["portals"] = "Portals"
L["portals_desc"] = "Information about portals after a boss dies."
L["portal_message15s"] = "%s in ~15 seconds!"
L["portal_message95s"] = "%s in ~95 seconds!"
--@end-do-not-package@
--@localization(locale="enUS", namespace="Dalaran/The_Violet_Hold", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: The Violet Hold")
mod.locale = L
mod.displayName = L["portals"]

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Deaths", 29315,29316,29313,29266,29312,29314,32226,32230,32231,32234,32235,32237)
	self:Death("Disable", 31134)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deaths()
	self:Message("portals", L["portal_message95s"], "Attention", "INV_Misc_ShadowEgg")
	self:DelayedMessage("portals", 80, L["portal_message15s"], "Attention", "INV_Misc_ShadowEgg")
	self:Bar("portals", L["next_portal"], 95, "INV_Misc_ShadowEgg")
end
