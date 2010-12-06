-- XXX Ulic: Other suggestions?  Perhaps if there is a timer between phases?  Is there a debuff or something to know an add is on you?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Drahga Shadowburner", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40319)
mod.toggleOptions = {
	{75321, "FLASHSHAKE"}, -- Valiona's Flame
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Flame", 75321)

	self:Death("Win", 40319)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Flame(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(75321, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(75321)
	end
end