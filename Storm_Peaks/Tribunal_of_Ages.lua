-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Tribunal of Ages", "Halls of Stone")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27978)
mod.toggleOptions = {"timers", "bosskill"}

-------------------------------------------------------------------------------
--  Locals

local started = nil

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Tribunal of Ages", "enUS", true)
if L then
--@do-not-package@
L["defeat_trigger"] = "Ha! The old magic fingers finally won through! Now let's get down to-"
L["enable_trigger"] = "Place Holder"
L["engage_trigger"] = "Take a moment and relish this with me! Soon all will be revealed! Okay then, lets do this!"

L["timers"] = "Timers"
L["timers_desc"] = "Timers for various events that take place."
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
	stated = nil
	self:Yell("Engage", L["engage_trigger"])
	self:Yell("Win", L["defeat_trigger"])
end

function mod:OnEngage()
	if started then return end
	stated = true
	self:Bar("timers", "Enter Combat", 45, "Ability_DualWield")
	self:Bar("timers", "First wave!", 50, "Ability_DualWield")
	self:Bar("timers", "Victory!", 315, "INV_Misc_PocketWatch_01")
end
