-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Tribunal of Ages", "Halls of Stone")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27978)
mod.toggleOptions = {"timers", "bosskill"}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Tribunal of Ages", "enUS", true)
if L then
--@do-not-package@
	L["enable_trigger"] = "Time to get some answers"
	L["engage_trigger"] = "Take a moment and relish this with me"
	L["defeat_trigger"] = "The old magic fingers"

	L["timers"] = "Timers"
	L["timers_desc"] = "Timers for various events that take place."

	L["combat"] = "Enter Combat"
	L["wave"] = "First wave!"
	L["victory"] = "Victory!"
--@end-do-not-package@
--@localization(locale="enUS", namespace="Storm_Peaks/Tribunal_of_Ages", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Tribunal of Ages")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnRegister()
	self:RegisterEnableYell(L["enable_trigger"])
end

function mod:OnBossEnable()
	self:Yell("Engage", L["engage_trigger"])
	self:Yell("Win", L["defeat_trigger"])

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

function mod:OnEngage()
	self:Bar("timers", L["combat"], 45, "Ability_DualWield")
	self:Bar("timers", L["wave"], 50, "Ability_DualWield")
	self:Bar("timers", L["victory"], 315, "INV_Misc_PocketWatch_01")
end
