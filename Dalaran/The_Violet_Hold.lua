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

	portal = "Portal Warnings",
	portal_desc = "Announce approximate warning messages for the next portal.",

	portalbar = "Wave Bars",
	portalbar_desc = "Display approximate timer bars for the next portal.",
	
	next_portal = "Next Portal",

	portal_bar = "~%s: %s", --shouldn't require translation

	portal_message15s = "%s in ~15 seconds!",
	portal_message95s = "%s in ~95 seconds!",
} end )

L:RegisterTranslations("koKR", function() return {
	sinclari = "부관 신클래리",
	
	portal = "차원문 경고",
	portal_desc = "다음 차원문에 대하여 알립니다.",

	portalbar = "웨이브 바",
	portalbar_desc = "다음 포탈에 대한 웨이브 바를 표시합니다.",

	next_portal = "다음 차원문",

	portal_bar = "~%s: %s", --shouldn't require translation

	portal_message15s = "약 15초 후 %s !",
	portal_message95s = "약 95초 후 %s !",
} end )

L:RegisterTranslations("frFR", function() return {
	sinclari = "Lieutenant Sinclari",

	portal = "Avertissements des portails",
	portal_desc = "Prévient quand le prochain portail arrive (approximatif).",

	portalbar = "Barres des vagues",
	portalbar_desc = "Affiche des délais approximatifs avant le prochain portail.",

	next_portal = "Prochain portail",

	portal_bar = "~%s : %s", -- undividable space FTW!

	portal_message15s = "%s dans ~15 sec. !",
	portal_message95s = "%s dans ~95 sec. !",
} end )

L:RegisterTranslations("zhTW", function() return {
	sinclari = "辛克拉麗中尉",

	portal = "傳送門警報",
	portal_desc = "當下一個傳送門即將開啟時發出警報。",

	portalbar = "傳送門計時條",
	portalbar_desc = "當下一個傳送門即將開啟時顯示計時條。",
	
	next_portal = "下一個傳送門",

	portal_bar = "<%s：波 %s>", --shouldn't require translation

	portal_message15s = "約15秒后，%s！",
	portal_message95s = "約95秒后，%s！",
} end )

L:RegisterTranslations("deDE", function() return {
	sinclari = "Leutnant Sinclari",

	portal = "Portal-Warnungen",
	portal_desc = "Ungef\195\164hre Warnungen f\195\188r das n\195\164chste Portal ank\195\188ndigen.",

	portalbar = "Wellen-Anzeige",
	portalbar_desc = "Ungef\195\164hre Timer-Leisten f\195\188r das n\195\164chste Portal anzeigen.",
	
	next_portal = "N\195\164chstes Portal",

	portal_bar = "~%s: %s", --shouldn't require translation

	portal_message15s = "%s in ~15 Sekunden!",
	portal_message95s = "%s in ~95 Sekunden!",
} end )

L:RegisterTranslations("zhCN", function() return {
	sinclari = "辛克莱尔中尉",

	portal = "传送门警报",
	portal_desc = "当下一个传送门即将开启时发出警报。",

	portalbar = "传送门计时条",
	portalbar_desc = "当下一个传送门即将开启时显示计时条。",
	
	next_portal = "下一个传送门",

	portal_bar = "<%s：波 %s>", --shouldn't require translation

	portal_message15s = "约15秒后，%s！",
	portal_message95s = "约95秒后，%s！",
} end )

L:RegisterTranslations("ruRU", function() return {
	sinclari = "Лейтенант Синклари",

	portal = "Предупреждать о порталах",
	portal_desc = "Оповещать о порталах.",

	portalbar = "Полосы волн",
	portalbar_desc = "Отображать таймер до следующего портала.",

	next_portal = "Следующий портал",

	portal_bar = "~%s: %s", --shouldn't require translation

	portal_message15s = "%s через ~15 сек!",
	portal_message95s = "%s через ~95 сек!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(name)
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = L["sinclari"]
mod.guid = 31134
mod.toggleoptions = {"portal", "portalbar", "bosskill"}
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

	-- Disable the module if the final boss has just died
	if guid == self.guid then
		BigWigs:ToggleModuleActive(self, false)
		return
	end

	for _,v in ipairs(guids) do
		if v == guid then
			bossdeaths = bossdeaths + 1
			if bossdeaths == 1 then
				portal = 7
			elseif bossdeaths == 2 then
				portal = 13
			end
			if self.db.profile.portal then
				self:IfMessage(L["portal_message95s"]:format(L["next_portal"]), "Attention", "INV_Misc_ShadowEgg")
			end
			if self.db.profile.portalbar then
				self:Bar(L["portal_bar"]:format(L["next_portal"],portal), 95, "INV_Misc_ShadowEgg")
			end
		end
	end
end
