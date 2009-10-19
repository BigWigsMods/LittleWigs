-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Magus Telestra", "The Nexus")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(26731)
mod.toggleOptions = {"split", "bosskill"}

-------------------------------------------------------------------------------
--  Locals

local split1announced = nil
local split2announced = nil
local difficulty

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Grand Magus Telestra", "enUS", true)
if L then
	--@do-not-package@
	L["split"] = "Split"
	L["split_desc"] = "Warn when Grand Magus Telestra is about to split."
	L["split_soon_message"] = "Spliting Soon"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Coldarra/Grand_Magus_Telestra", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Grand Magus Telestra")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Death("Win", 26731)
	
	if bit.band(self.db.profile.split, BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
		self:RegisterEvent("UNIT_HEALTH")
	end

	difficulty = GetInstanceDifficulty()
end

function mod:OnEngage()
	split1announced = nil
	split2announced = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local currentHealth = UnitHealth(msg)
	local maxHealth = UnitHealthMax(msg)
	local health = (currentHealth/maxHealth)*100
	if health > 51 and health <= 55 and not split1announced then
		self:Message("split", L["split_soon_message"], "Attention")
		split1announced = true
	elseif difficulty == 2 and not split2announced and health > 11 and health <= 15 then
		self:Message("split", L["split_soon_message"], "Attention")
		split2announced = true
	elseif (split1announced or split2announced) and health > 60 then
		split1announced = false
		split2announced = false
	end
end
