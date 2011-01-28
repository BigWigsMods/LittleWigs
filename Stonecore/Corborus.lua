-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Corborus", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43438)
mod.toggleOptions = {"burrow", {92648, "FLASHSHAKE"}, "bosskill"}

local L = mod:NewLocale("enUS", true)
if L then
	L.burrow = "Burrow/emerge"
	L.burrow_desc = "Warn when Corborus burrows or emerges."
	L.burrow_bar = "%s burrows"
	L.emerge_bar = "%s emerges"
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
	self:Bar("burrow", L["burrow_bar"]:format(self.displayName), 30, "ABILITY_HUNTER_PET_WORM")
	self:ScheduleTimer("Emerge", 30)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Emerge()
	self:LocalMessage("burrow", L["emerge_bar"]:format(self.displayName), "Important", "ABILITY_HUNTER_PET_WORM", "Alert") -- debug
	self:Bar("burrow", L["emerge_bar"]:format(self.displayName), 30, "ABILITY_HUNTER_PET_WORM")
	self:ScheduleTimer("Burrow", 30)
end

function mod:Burrow()
	self:LocalMessage("burrow", L["burrow_bar"]:format(self.displayName), "Important", "ABILITY_HUNTER_PET_WORM", "Alert") -- debug
	self:Bar("burrow", L["burrow_bar"]:format(self.displayName), 30, "ABILITY_HUNTER_PET_WORM")
	self:ScheduleTimer("Emerge", 30)
end

function mod:Barrage(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(92648, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(92648)
	end
end

