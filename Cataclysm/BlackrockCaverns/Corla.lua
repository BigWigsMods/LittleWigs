-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Corla, Herald of Twilight", 645, 106)
if not mod then return end
mod:RegisterEnableMob(39679)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{75610, "FLASH"}, -- Evolution
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "Evolution", 75610, 87378)
	self:Log("SPELL_AURA_REMOVED", "EvolutionRemoved", 75610, 87378)

	self:Death("Win", 39679)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Evolution(args)
	if self:Me(args.destGUID) and args.amount > 75 and not warned then
		warned = true
		self:StackMessage(75610, args.destName, args.amount, "Personal", "Alarm")
		self:Flash(75610)
	end
end

function mod:EvolutionRemoved(args)
	if self:Me(args.destGUID) and warned then
		warned = nil
		self:Message(75610, "Positive", nil, CL.removed(args.spellName))
	end
end

