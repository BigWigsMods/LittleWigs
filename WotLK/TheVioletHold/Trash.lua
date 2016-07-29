-------------------------------------------------------------------------------
--  Module Declaration 

-- "Portals" isn't going to work, gonna have to rethink that
local mod = BigWigs:NewBoss("Portals", 536)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(30658,29315,29316,29313,29266,29312,29314,32226,32230,32231,32234,32235,32237)
mod.toggleOptions = {"portals"}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["portals"] = "Portals"
L["next_portal"] = "Portal %d"
L["portal_opened"] = "Portal %d opened"
L["portals_desc"] = "Information about portals."
L["engage_trigger"] = "I'm locking the door."
L["portal_message15s"] = "Portal %d in ~15 seconds!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Dalaran/The_Violet_Hold", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
mod.displayName = L["portals"]

-------------------------------------------------------------------------------
--  Initialization
local lastportal = 0

function mod:OnBossEnable()
	self:RegisterEvent("UPDATE_WORLD_STATES")
	self:Death("Deaths", 29315,29316,29313,29266,29312,29314,32226,32230,32231,32234,32235,32237)
	self:Death("Disable", 31134)

	self:Yell("Warmup", L["engage_trigger"])
end

function mod:Warmup()
	self:Bar("portals", self.zoneName, 25, "achievement_dungeon_theviolethold_normal")
	self:DelayedMessage("portals", 10, L["portal_message15s"]:format(1), "Attention")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deaths()
	self:DelayedMessage("portals", 20, L["portal_message15s"]:format(lastportal+1), "Attention")
	self:Bar("portals", L["next_portal"]:format(lastportal+1), 35, "INV_Misc_ShadowEgg")
end

function mod:UPDATE_WORLD_STATES()
	local text = select(3, GetWorldStateUIInfo(2))
	if not text then return end
	local portal = tonumber(text:match("([0-9]+)/18")) or 0
	if portal < lastportal then -- wiped probably
		lastportal = 0
	elseif portal > lastportal then
		self:SendMessage("BigWigs_StopBar", self, L["next_portal"]:format(lastportal+1))
		self:CancelDelayedMessage(L["portal_message15s"]:format(lastportal+1))
		if portal ~= 6 and portal ~= 12 and portal ~= 18 then
			self:Message("portals", L["portal_opened"]:format(portal), "Important", "INV_Misc_ShadowEgg")
			self:Bar("portals", L["next_portal"]:format(portal+1), 120, "INV_Misc_ShadowEgg")
			self:DelayedMessage("portals", 105, L["portal_message15s"]:format(portal+1), "Attention")
		end
		lastportal = portal
	end
end
