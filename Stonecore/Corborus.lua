-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Corborus", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43438)
mod.toggleOptions = {"burrow", {92648, "FLASHSHAKE"}, "bosskill"}

local L = mod:NewLocale("enUS", true)
if L then--@do-not-package@
	L.burrow = "Burrow/emerge"
	L.burrow_desc = "Warn when Corborus burrows or emerges."
	L.burrow_message = "Corborus burrows"
	L.burrow_warning = "Burrow in 5 sec!"
	L.emerge_message = "Corborus emerges!"
	L.emerge_warning = "Emerge in 5 sec!"--@end-do-not-package@
--@localization(locale="enUS", namespace="GrimBatol/Corborus", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 81634, 81637, 81638, 86881, 92012, 92648) -- 92648 is heroic

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 43438)
end

function mod:OnEngage()
	self:Bar("burrow", L["burrow_message"], 30, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 25, L["burrow_warning"], "Attention")
	self:ScheduleTimer("Burrow", 30)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Burrow()
	self:Message("burrow", L["burrow_message"], "Important", "Interface\\Icons\\ABILITY_HUNTER_PET_WORM", "Info")
	self:Bar("burrow", L["emerge_message"], 30, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 25, L["emerge_warning"], "Attention")
	self:ScheduleTimer("Emerge", 30)
end

function mod:Emerge()
	self:Message("burrow", L["emerge_message"], "Important", "Interface\\Icons\\ABILITY_HUNTER_PET_WORM", "Info")
	self:Bar("burrow", L["burrow_message"], 90, "ABILITY_HUNTER_PET_WORM")
	self:DelayedMessage("burrow", 85, L["burrow_warning"], "Attention")
	self:ScheduleTimer("Burrow", 90) --guesstimate
end

do
	local bw_you = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(GetSpellInfo(92648))
	function mod:Barrage(player, spellId)
		if UnitIsUnit(player, "player") then
			self:LocalMessage(92648, bw_you, "Personal", spellId, "Alarm")
			self:FlashShake(92648)
		end
	end
end

