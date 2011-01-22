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
	self:Log("SPELL_AURA_APPLIED", "Barrage", 81634, 81637, 81638, 86881, 92012, 92648)

	self:Death("Win", 43438)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Barrage(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(92648, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(92648)
	end
end

