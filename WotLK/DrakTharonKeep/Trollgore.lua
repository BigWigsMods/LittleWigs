-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Trollgore", 534, 588)
if not mod then return end
--mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26630)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		49637, -- Infected Wound
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "InfectedWound", 49637)
	self:Log("SPELL_AURA_REMOVED", "InfectedWoundRemoved", 49637)
	self:Death("Win", 26630)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:InfectedWound(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:InfectedWoundRemoved(args)
	self:StopBar(args.spellId, args.destName)
end
