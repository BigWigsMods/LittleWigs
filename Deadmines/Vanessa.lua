-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Vanessa VanCleef", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(49541)
mod.toggleOptions = {92614, 95542, {90961, "FLASHSHAKE", "SAY", "ICON"}, "bosskill"}

--------------------------------------------------------------------------------
-- Locals

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Deflection", 92614)
	self:Log("SPELL_CAST_SUCCESS", "Vengeance", 95542)
	self:Log("SPELL_AURA_APPLIED", "Blades", 90961) -- actually used by Defias Shadowguards
	self:Log("SPELL_AURA_REMOVED", "BladesRemoved", 90961)

	self:Death("Win", 49541)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deflection(_, spellId, _, _, spellName)
	self:Message(92614, spellName, "Urgent", spellId)
	self:Bar(92614, spellName, 10, spellId)
end

function mod:Vengeance(_, spellId, _, _, spellName)
	self:Message(95542, spellName, "Attention", spellId, "Long")
end

function mod:Blades(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(90961, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:Say(90961, BCL["say"]:format(spellName))
		self:FlashShake(90961)
	end
	self:PrimaryIcon(90961, player)
end

function mod:BladesRemoved()
	self:PrimaryIcon(90961)
end

