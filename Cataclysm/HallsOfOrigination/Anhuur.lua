-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Temple Guardian Anhuur", 759, 124)
if not mod then return end
mod:RegisterEnableMob(39425)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		74938, -- Shield of Light
		{75592, "ICON", "FLASH"}, -- Divine Reckoning
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ShieldOfLight", 74938)
	self:Log("SPELL_AURA_APPLIED", "DivineReckoning", 75592)
	self:Log("SPELL_AURA_REMOVED", "DivineReckoningRemoved", 75592)
	self:Death("Win", 39425)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ShieldOfLight(args)
	self:Message(args.spellId, "Important", "Long")
end

function mod:DivineReckoning(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:DivineReckoningRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellId, args.destName)
end
