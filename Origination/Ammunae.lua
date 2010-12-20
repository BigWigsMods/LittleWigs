
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ammunae", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39731)
mod.toggleOptions = {76043, 75790, "bosskill"}
mod.optionHeaders = {
	[76043] = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Wither", 76043)
	self:Log("SPELL_AURA_REMOVED", "WitherRemoved", 76043)
	self:Log("SPELL_CAST_START", "Growth", 75790, 89888)

	self:Death("Win", 39731)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Wither(player, _, _, _, spellName)
	self:Message(76043, spellName..": "..player, "Important", 76043)
	self:Bar(76043, player..": "..spellName, 10, 76043)
end

function mod:WitherRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Growth(_, spellId, _, _, spellName)
	self:Message(75790, spellName, "Urgent", spellId, "Alarm")
end
