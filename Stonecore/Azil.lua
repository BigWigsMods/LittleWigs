-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Priestess Azil", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42333)
mod.toggleOptions = {79345, 79050, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 79345, 92663)
	self:Log("SPELL_CAST_START", "Shield", 79050, 82858, 92667)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 42333)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Curse(player, spellId, _, _, spellName)
	self:TargetMessage(79345, spellName, player, "Attention", spellId)
end

function mod:Shield(_, spellId, _, _, spellName)
	self:Message(79050, spellName, "Important", spellId, "Alert")
end

