-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Corborus", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43438)
mod.toggleOptions = {{92648, "FLASHSHAKE"}, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 81634, 81637, 81638, 86881, 92012, 92648) --92648 is heroic

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 43438)
end

function mod:OnEngage()
	self:Bar(92662, "Goes Under", 30, "ABILITY_HUNTER_PET_WORM")
	self:ScheduleTimer("Emerge", 30)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Emerge()
	self:Bar(92662, "Emerges", 60, "ABILITY_HUNTER_PET_WORM")
end

function mod:Barrage(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(92648, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(92648)
	end
end

