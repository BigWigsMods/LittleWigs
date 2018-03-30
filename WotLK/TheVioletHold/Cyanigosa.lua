-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Cyanigosa", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(31134)
mod.toggleOptions = {
	{58693, "FLASHSHAKE"}, -- Blizzard
	59374, -- Destruction
}

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Blizzard", 58693, 59369)
	self:Log("SPELL_AURA_APPLIED", "Destruction", 59374)
	self:Log("SPELL_AURA_REMOVED", "DestructionRemoved", 59374)
	self:Death("Win", 31134)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Blizzard(player, spellId, _, _, spellName)
	if player == pName then
		self:LocalMessage(58693, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(58693)
	end
end

function mod:Destruction(player, spellId, _, _, spellName)
	self:Message(58693, spellName..": "..player, "Important", spellId)
	self:Bar(58693, player..": "..spellName, 8, spellId)
end

function mod:DestructionRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
