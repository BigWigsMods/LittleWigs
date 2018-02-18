-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Infinite Corruptor", nil, nil, 595)
if not mod then return end
--mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(32273)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		60588, -- Corrupting Blight
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CorruptingBlight", 60588)
	self:Log("SPELL_AURA_REMOVED", "CorruptingBlightRemoved", 60588)
	self:Death("Win", 32273)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CorruptingBlight(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 120, args.destName)
end

function mod:CorruptingBlightRemoved(args)
	self:StopBar(args.spellId, args.destName)
end
