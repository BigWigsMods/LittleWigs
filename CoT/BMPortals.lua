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

	next_portal = "Next Portal",

	portal = "Portal Warnings",
	portal_desc = "Announce approximate warning messages for the next portal.",

	portalbar = "Portal Bars",
	portalbar_desc = "Display approximate timer bars for the next portal.",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "~Multiple portals at once",

	portal_warning20s = "%s in ~20 seconds!",
	portal_warning140s = "%s in ~140 seconds!",

	engage_trigger = "^The time has come! Gul'dan",

	-- These triggers generate warnings & bars bars based on mob deaths
	death_trigger1 = "No! The rift...", --Time-Keeper/Lord
	death_trigger2 = "You will never defeat us all!", --Time-Keeper/Lord
	death_trigger3 = "You will accomplish nothing!", --Time-Keeper/Lord
	death_trigger4 = "Time... is on our side.", --Chrono Lord Deja
	death_trigger5 = "My death means... little.", -- Temporus

	-- These triggers generate a bar indicating that a second portal will open if the current portal's elite is not defeated
	-- I am not sure if it is possible for a second portal to open on a boss fight
	spawn_trigger1 = "Let the siege begin!",--Time-Keeper/Lord
	spawn_trigger2 = "History is about to be rewritten!", --Time-Keeper/Lord
	spawn_trigger3 = "The sands of time shall be scattered to the winds!", --Time-Keeper/Lord
} end )

L:RegisterTranslations("zhTW", function() return {
	name = "黑色沼澤傳送門",
	name_desc = "傳送門開啟計時器及警報",
	On = "開啟",
	toggle = "切換此選項開啟或是關閉",

	next_portal = "下一個傳送門",

	portal = "傳送門警報",
	portal_desc = "廣播下一個傳送門即將開啟的警報訊息",

	portalbar = "傳送門計時條",
	portalbar_desc = "顯示下一個傳送門的計時條",

	portal_bar = "~%s: Wave %s",

	portal_warning20s = "20 秒後 %s 波！",
	portal_warning140s = "140 秒後 %s 波！",

	death_trigger1 = "No! The rift...",
	death_trigger2 = "You will never defeat us all!",
	death_trigger3 = "You will accomplish nothing!",
	death_trigger4 = "Time... is on our side.",
	death_trigger5 = "My death means... little.",
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
				if v then
					mod:ZONE_CHANGED_NEW_AREA()
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
				if v then
					mod:ZONE_CHANGED_NEW_AREA()
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
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:ZONE_CHANGED_NEW_AREA()
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.portal and not self.db.profile.portalbar then return end
	if msg == L["death_trigger1"] or msg == L["death_trigger2"] or msg == L["death_trigger3"] or msg == L["death_trigger4"] or msg == L["death_trigger5"] then
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
			self:TriggerEvent("BigWigs_StopBar", self, L["multiportal_bar"])
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
	if msg:find(L["engage_trigger"]) then
		wave = 1
		self:Bar(L["portal_bar"]:format(L["next_portal"],wave), 15, "INV_Misc_ShadowEgg")
		wave = 2
	end
	if (msg == L["spawn_trigger1"] or msg == L["spawn_trigger2"] or msg == L["spawn_trigger3"]) and self.db.profile.portalbar then
		self:Bar(L["multiportal_bar"], 125, "INV_Misc_ShadowEgg")
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	if GetRealZoneText() ~= BZ["The Black Morass"] then return end
	if (self.db.profile.portal or self.db.profile.portalbar) and not self:IsEventRegistered("CHAT_MSG_MONSTER_YELL") then
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	end	
end
