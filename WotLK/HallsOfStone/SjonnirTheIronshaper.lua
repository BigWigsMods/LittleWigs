-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Sjonnir The Ironshaper", 526)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27978)
mod.toggleOptions = {
	50834, -- Charge
	50840, -- Ring
}

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Charge", 50834, 59846)
	self:Log("SPELL_CAST_SUCCESS", "Ring", 50840, 59848, 59861, 51849)
	self:Death("Win", 27978)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Charge(player, spellId, _, _, spellName)
	self:TargetMessage(50834, spellName, player, "Personal", spellId, "Alarm")
	self:Bar(50834, player..": "..spellName, 10, spellId)
end

function mod:Ring(_, spellId, _, _, spellName)
	self:Message(50840, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(50840, spellName, 10, spellId)
end
