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
local portal = 0
local bossdeaths = 0

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)

L:RegisterTranslations("enUS", function() return {
	cmd = "VioletHold",
	next_portal = "Next Portal",
	portal = "Portal Warnings",
	portalbar = "Wave Bars",
	portal_bar = "~%s: %s",
	portalbar_desc = "Display approximate timer bars for the next portal.",
	portal_desc = "Announce approximate warning messages for the next portal.",
	portal_message15s = "%s in ~15 seconds!",
	portal_message95s = "%s in ~95 seconds!",
	sinclari = "Lieutenant Sinclari",
}

end )

L:RegisterTranslations("deDE", function() return {
	cmd = "VioletHold",
	next_portal = "Nächstes Portal",
	portal = "Portal-Warnungen",
	portalbar = "Wellen-Anzeige",
	portal_bar = "~%s: %s",
	portalbar_desc = "Ungefähre Zeitanzeige für das nächste Portal anzeigen.",
	portal_desc = "Ungefähre Warnmeldungen für das nächste Portal ansagen.",
	portal_message15s = "%s in ~15 Sekunden!",
	portal_message95s = "%s in ~95 Sekunden!",
	sinclari = "Leutnant Sinclari",
}

end )

L:RegisterTranslations("esES", function() return {
}

end )

L:RegisterTranslations("esMX", function() return {
}

end )

L:RegisterTranslations("frFR", function() return {
	cmd = "VioletHold",
	next_portal = "Prochain portail",
	portal = "Avertissements des portails",
	portalbar = "Barres des vagues",
	portal_bar = "~%s : %s",
	portalbar_desc = "Affiche des délais approximatifs avant le prochain portail.",
	portal_desc = "Prévient quand le prochain portail arrive (approximatif).",
	portal_message15s = "%s dans ~15 sec. !",
	portal_message95s = "%s dans ~95 sec. !",
	sinclari = "Lieutenant Sinclari",
}

end )

L:RegisterTranslations("koKR", function() return {
	cmd = "보라빛요새",
	next_portal = "다음 차원문",
	portal = "차원문 경고",
	portalbar = "웨이브 바",
	portal_bar = "~%s: %s",
	portalbar_desc = "다음 포탈에 대한 웨이브 바를 표시합니다.",
	portal_desc = "다음 차원문에 대하여 알립니다.",
	portal_message15s = "약 15초 후 %s !",
	portal_message95s = "약 95초 후 %s !",
	sinclari = "부관 신클래리",
}

end )

L:RegisterTranslations("ruRU", function() return {
	next_portal = "Следующий портал",
	portal = "Предупреждать о порталах",
	portalbar = "Полосы порталов",
	portal_bar = "~%s: %s",
	portalbar_desc = "Отображать таймер до следующего портала.",
	portal_desc = "Отображать таймер до следующего портала.",
	portal_message15s = "%s через ~15 сек!",
	portal_message95s = "%s через ~95 сек!",
	sinclari = "Лейтенант Синклари",
}

end )

L:RegisterTranslations("zhCN", function() return {
	next_portal = "下一个传送门",
	portal = "传送门警报",
	portalbar = "传送门计时条",
	portal_bar = "<%s：波 %s>",
	portalbar_desc = "当下一个传送门即将开启时显示计时条。",
	portal_desc = "当下一个传送门即将开启时发出警报。",
	portal_message15s = "约15秒后，%s！",
	portal_message95s = "约95秒后，%s！",
	sinclari = "辛克莱尔中尉",
}

end )

L:RegisterTranslations("zhTW", function() return {
	next_portal = "下一個傳送門",
	portal = "傳送門警報",
	portalbar = "傳送門計時條",
	portal_bar = "<%s：波 %s>",
	portalbar_desc = "當下一個傳送門即將開啟時顯示計時條。",
	portal_desc = "當下一個傳送門即將開啟時發出警報。",
	portal_message15s = "約15秒後，%s！",
	portal_message95s = "約95秒後，%s！",
	sinclari = "辛克拉麗中尉",
}

end )

----------------------------------
--        Initialization        --
----------------------------------

-- Since this is a unique module we have to sneak this down after it's been translated
mod.enabletrigger = L["sinclari"]

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "Deaths")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	bossdeaths = 0
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
