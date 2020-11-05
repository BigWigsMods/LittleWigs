-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Maker", 542, 555)
if not mod then return end
mod:RegisterEnableMob(17381)
-- mod.engageId = 1922 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		30923, -- Domination
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Domination", 30923)
	self:Log("SPELL_AURA_REMOVED", "DominationRemoved", 30923)
	self:Death("Win", 17381)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Domination(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:DominationRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
