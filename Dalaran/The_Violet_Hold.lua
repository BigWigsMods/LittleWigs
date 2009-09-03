----------------------------------
--      Module Declaration      --
----------------------------------

local name = BZ["The Violet Hold"]
local mod = BigWigs:New(name, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.guid = 31134
mod.toggleOptions = {"portal", "portalbar", "bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local guids = {29315,29316,29313,29266,29312,29314,32226,32230,32231,32234,32235,32237}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dalaran/The_Violet_Hold", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

-- Since this is a unique module we have to sneak this down after it's been translated
mod.enabletrigger = L["sinclari"]

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "Deaths")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Deaths(_, guid)
	guid = tonumber((guid):sub(-12,-7),16)

	-- Disable the module if the final boss has just died
	if guid == self.guid then
		BigWigs:ToggleModuleActive(self, false)
		return
	end

	for _,v in ipairs(guids) do
		if v == guid then
			if self.db.profile.portal then
				self:IfMessage(L["portal_message95s"]:format(L["next_portal"]), "Attention", "INV_Misc_ShadowEgg")
				self:DelayedMessage(80, L["portal_message15s"]:format(L["next_portal"]), "Attention", "INV_Misc_ShadowEgg")
			end
			if self.db.profile.portalbar then
				self:Bar(L["next_portal"], 95, "INV_Misc_ShadowEgg")
			end
		end
	end
end
