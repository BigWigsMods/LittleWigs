-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Corla, Herald of Twilight", 753)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39679)
mod.toggleOptions = {
	{75610, "FLASHSHAKE"}, -- Evolution
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "Evolution", 75610, 87378)
	self:Log("SPELL_AURA_REMOVED", "EvolutionRemoved", 75610, 87378)

	self:Death("Win", 39679)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Evolution(player, spellId, _, _, spellName, stack)
	if UnitIsUnit(player, "player") and stack > 75 and not warned then
		warned = true
		self:LocalMessage(75610, CL.stackyou:format(stack), "Personal", spellId, "Alarm")
		self:FlashShake(75610)
	end
end

function mod:EvolutionRemoved(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") and warned then
		warned = nil
	end
end

