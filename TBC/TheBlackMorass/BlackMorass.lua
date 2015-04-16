-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Portals", 733)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(15608)
mod.toggleOptions = {"wave"}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0
local waveCount = 0

-------------------------------------------------------------------------------
--  Localization

local BB = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Black Morass", "enUS", true)
if L then
	--@do-not-package@
	L["next_wave"] = "Next Wave"

	L["wave"] = "Wave Warnings"
	L["wave_desc"] = "Announce approximate warning messages for the waves."

	L["wave_bar"] = "~%s: Wave %s"
	L["multiwave_bar"] = "~Until Multiple waves"

	L["wave_message15s"] = "%s in ~15 seconds!"
	L["wave_message140s"] = "%s in ~140 seconds!"

	L["disable_trigger"] = "We will triumph. It is only a matter... of time."
	L["disable_message"] = "%s has been saved!"
	L["reset_trigger"] = "No! Damn this feeble, mortal coil!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Black_Morass", format="lua_additive_table", handle-unlocalized="ignore", handle-subnamespaces="concat")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Black Morass")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("BossDeath", 17881, 17879, 17880)
	self:RegisterEvent("UPDATE_WORLD_STATES")
	self:Yell("OnDisable", L["disable_trigger"])
	self:Yell("Reboot", L["reset_trigger"])

	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:BossDeath()
	deaths = deaths + 1
	if deaths == 1 then
		waveCount = 6
	elseif deaths == 2 then
		waveCount = 12
	end
	self:Message("wave", L["wave_message140s"]:format(L["next_wave"]), "Attention")
	self:Bar("wave", L["wave_bar"]:format(L["next_wave"],waveCount+1), 125, "INV_Misc_ShadowEgg")
end

-- Thanks to Ammo and Mecdemort for their work on the MountHyjal Wave timers which these new BM timers were based on
function mod:UPDATE_WORLD_STATES()
	if self.zonename ~= GetRealZoneText() then return end
	local _, _, text = GetWorldStateUIInfo(2)
	local num = tonumber((text or ""):match("(%d+)") or nil)
	if num and num > waveCount then
		waveCount = waveCount + 1
		self:SendMessage("BigWigs_StopBar", self, L["multiwave_bar"])
		if waveCount == 6 then
			self:Message("wave", L["wave_message15s"]:format(BB["Chrono Lord Deja"]), "Attention")
			self:Bar("wave", L["wave_bar"]:format(BB["Chrono Lord Deja"], waveCount), 15, "INV_Misc_ShadowEgg")
		elseif waveCount == 12 then
			self:Message("wave", L["wave_message15s"]:format(BB["Temporus"]), "Attention")
			self:Bar("wave", L["wave_bar"]:format(BB["Temporus"], waveCount), 15, "INV_Misc_ShadowEgg")
		elseif waveCount == 18 then
			self:Message("wave", L["wave_message15s"]:format(BB["Aeonus"]), "Attention")
			self:Bar("wave", L["wave_bar"]:format(BB["Aeonus"], waveCount), 15, "INV_Misc_ShadowEgg")
		else
			self:Message("wave", L["wave_message15s"]:format(L["next_wave"]), "Attention")
			self:Bar("wave", L["multiwave_bar"], 127, "INV_Misc_ShadowEgg")
			self:Bar("wave", L["wave_bar"]:format(L["next_wave"], waveCount), 15, "INV_Misc_ShadowEgg")
		end
	end
end

