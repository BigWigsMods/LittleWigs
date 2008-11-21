------------------------------
--      Are you local?      --
------------------------------

local name = BZ["The Violet Hold"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)

local guids = {29315,29316,29313,29266,29312,29314}
local portal = 0
local bossdeaths = 0

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "VioletHold",
	
	sinclari = "Lieutenant Sinclari",

	next_portal = "Next Portal",

	portal_bar = "~%s: %s", --shouldn't require translation

	portal_message15s = "%s in ~15 seconds!",
	portal_message95s = "%s in ~95 seconds!",	
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
	sinclari = "Leutnant Sinclari",

	next_portal = "N\195\164chstes Portal",

	portal_message15s = "%s in ~15 Sekunden!",
	portal_message140s = "%s in ~95 Sekunden!",
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = L["sinclari"]
mod.guid = 31134
mod.toggleoptions = {"bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "Deaths")

	bossdeaths = 0
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Deaths(_, guid)
	guid = tonumber((guid):sub(-12,-7),16)
	for _,v in ipairs(guids) do
		if v == guid then
			bossdeaths = bossdeaths + 1
		end
	end

	if bossdeaths == 1 then
		portal = 7
	elseif bossdeaths == 2 then
		portal = 13
	end

	if self.db.profile.portal then
		self:Message(L["portal_message95s"]:format(L["next_portal"]), "Attention")
	end

	if self.db.profile.portalbar then
		self:Bar(L["portal_bar"]:format(L["next_portal"],portal), 95, "INV_Misc_ShadowEgg")
	end

	if guid == self.guid then
		self:BossDeath(nil, self.guid, true)
	end
end
