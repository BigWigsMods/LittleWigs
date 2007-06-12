------------------------------
--      Are you local?      --
------------------------------

local BB = AceLibrary("Babble-Boss-2.2")
local BZ = AceLibrary("Babble-Zone-2.2")

local name = "The Black Morass Portals"
local BMPortals = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)

local boss1 = BB["Chrono Lord Deja"]
local boss2 = BB["Temporus"]
local boss3 = BB["Aeonus"]

BB = nil

L:RegisterTranslations("enUS", function() return {
	cmd = "bmportals",
	
	name = "The Black Morass Portals",
	name_desc = "Options for warnings and timers for portal openings",
	On = "On",
	toggle = "Toggles the option on and off.",
	announcement = "%s: Please keep in mind that if you take an extra long time to kill the Rift-Keepers/Lords you could get a second portal up that would throw off the timers.",
	
	next_portal = "Next Portal",

	portal = "Portal Warnings",
	portal_desc = "Announce approximate warning messages for the next portal.",

	portalbar = "Portal Bars",
	portalbar_desc = "Display approximate timer bars for the next portal.",

	portal_bar = "~%s: Wave %s",
	
	portal_warning20s = "%s in ~20 seconds!",
	portal_warning140s = "%s in ~140 seconds!",

	portal_trigger1 = "No! The rift...",
	portal_trigger2 = "You will never defeat us all!",
	portal_trigger3 = "You will accomplish nothing!",
	portal_trigger4 = "Time... is on our side.",
	portal_trigger5 = "My death means... little.",	
} end )

L:RegisterTranslations("zhTW", function() return {

	name = "黑色沼澤傳送門",
	name_desc = "傳送門開啟計時器及警報",
	On = "開啟",
	toggle = "切換此選項開啟或是關閉",
	announcement = "%s: 請記住，如果你花費太多時間去擊殺 裂縫看守者/領主，你可能使得第二個傳送門啟動而匆匆拋掉計時器。",
	
	next_portal = "下一個傳送門",

	portal = "傳送門警報",
	portal_desc = "廣播下一個傳送門即將開啟的警報訊息",

	portalbar = "傳送門計時條",
	portalbar_desc = "顯示下一個傳送門的計時條",

	portal_bar = "~%s: Wave %s",
	
	portal_warning20s = "20 秒後 %s 波！",
	portal_warning140s = "140 秒後 %s 波！",

	portal_trigger1 = "No! The rift...",
	portal_trigger2 = "You will never defeat us all!",
	portal_trigger3 = "You will accomplish nothing!",
	portal_trigger4 = "Time... is on our side.",
	portal_trigger5 = "My death means... little.",	
} end )

local mod = BigWigs:NewModule(name)
mod.defaultDB = {
	portal = true,
	portalbar = true,
}

mod.consoleCmd = L["cmd"]
mod.consoleOptions = {
	type = "group",
	name = L["name"],
	desc = L["name_desc"],
	args   = {
		[L["portal"]] = {
			type = "toggle",
			name = L["portal"],
			desc = L["portal_desc"],
			get = function() return mod.db.profile.portal end,
			set = function(v)
				mod.db.profile.portal = v
				if v and not mod:IsEventRegistered("CHAT_MSG_MONSTER_YELL") then
					mod:RegisterEvent("CHAT_MSG_MONSTER_YELL")
				elseif mod:IsEventRegistered("CHAT_MSG_MONSTER_YELL") and not mod.db.profile.portalbar then
					mod:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				end
			end,
		},
		[L["portalbar"]] = {
			type = "toggle",
			name = L["portalbar"],
			desc = L["portalbar_desc"],
			get = function() return mod.db.profile.portalbar end,
			set = function(v)
				mod.db.profile.portalbar = v
				if v and not mod:IsEventRegistered("CHAT_MSG_MONSTER_YELL") then
					mod:RegisterEvent("CHAT_MSG_MONSTER_YELL")
				elseif mod:IsEventRegistered("CHAT_MSG_MONSTER_YELL") and not mod.db.profile.portal then
					mod:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				end
			end,
		},		
	}
}

mod.revision = tonumber(("$Revision$"):sub(12, -3))
mod.external = true

function mod:OnEnable()
	if GetRealZoneText() ~= BZ["The Black Morass"] then return end
	if self.db.profile.portal or self.db.profile.portalbar then
		BMPortals:Print(L["announcement"]:format(BZ["The Black Morass"]))
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
		wave = 2
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.portal and not self.db.profile.portalbar then return end
	if msg == L["portal_trigger1"] or msg == L["portal_trigger2"] or msg == L["portal_trigger3"] or msg == L["portal_trigger4"] or msg == L["portal_trigger5"] then
		if self.db.profile.portal then
			if wave == 6 then
				self:Message(L["portal_warning20s"]:format(boss1), "Attention")
			elseif wave == 12 then
				self:Message(L["portal_warning20s"]:format(boss2), "Attention")
			elseif wave == 18 then
				self:Message(L["portal_warning20s"]:format(boss3), "Attention")
			elseif wave == 7 or wave == 13 then
				self:Message(L["portal_warning140s"]:format(L["next_portal"]), "Attention")
				self:DelayedMessage(120, L["portal_warning20s"]:format(L["next_portal"]), "Attention")
			else
				self:Message(L["portal_warning20s"]:format(L["next_portal"]), "Attention")
			end
		end
		if self.db.profile.portalbar then
			if wave == 6 then
				self:Bar(L["portal_bar"]:format(boss1,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 12 then
				self:Bar(L["portal_bar"]:format(boss2,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 18 then
				self:Bar(L["portal_bar"]:format(boss3,wave), 20, "INV_Misc_ShadowEgg")
			elseif wave == 7 or wave == 13 then
				self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 140, "INV_Misc_ShadowEgg")
			else
				self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 20, "INV_Misc_ShadowEgg")
			end			
		end
		wave = wave + 1
	end
end
