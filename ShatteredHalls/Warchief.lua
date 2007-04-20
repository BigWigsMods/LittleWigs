------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Warchief Kargath Bladefist"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Warchief",

	bdwarn = "Warn for Blade Dance",
	bdwarn_desc = "Warn just before Warchief starts to Blade Dance",
	bdwarn_alert = "5 seconds until Blade Dance!",

	bdbar = "Blade Dance Bar",
	bdbar_desc = "Display count down bar for for Warchief's Blade Dance",
	bdbar_display = "Blade Dance",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Shattered Halls"]
mod.enabletrigger = boss
mod.toggleoptions = {"bdwarn", "bdbar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
	end
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "MagBD", 5)
end

------------------------------
--      Event Handlers      --
------------------------------


function mod:BigWigs_RecvSync( sync ) 
	if sync ~= "WarchiefBD" then return end
	if self.db.profile.bdwarn then
		self:DelayedMessage(25, L["bdwarn_alert"], "Urgent")
	end
	if self.db.profile.bdbar then
		self:Bar(L["bdbar_display"], 30, "Ability_DualWield")
	end
	if self.db.profile.bdbar or self.db.profile.bdwarn then
		self:ScheduleEvent("BigWigs_SendSync", 35, "WarchiefBD");
	end
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
	end
end

function mod:CheckForEngage()
	self:Sync("WarchiefBD")
end
