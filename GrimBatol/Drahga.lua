-- XXX Ulic: Other suggestions?  Perhaps if there is a timer between phases?  Is there a debuff or something to know an add is on you?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Drahga Shadowburner", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40319)
mod.toggleOptions = {
	{75321, "FLASHSHAKE"}, -- Valiona's Flame
	{90950, "FLASHSHAKE"}, -- Devouring Flames
	"bosskill",
}
local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
mod.optionHeaders = {
	[75321] = "normal",
	[90950] = "heroic",
	bosskill = "general",
}

-------------------------------------------------------------------------------
--  Localization



-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Flame", 75321)

	self:Death("Win", 40319)
end

function mod:VerifyEnable()
	if UnitInVehicle("player") then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Flame(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(75321, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(75321)
	end
end