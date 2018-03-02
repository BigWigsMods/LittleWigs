-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prince Keleseth", nil, 638, 574)
if not mod then return end
mod:RegisterEnableMob(23953)
mod.engageId = 2026
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		48400, -- Ice Tomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceTomb", 48400)
	self:Log("SPELL_AURA_REMOVED", "IceTombRemoved", 48400)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:IceTomb(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Warning", nil, nil, true)
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:IceTombRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
