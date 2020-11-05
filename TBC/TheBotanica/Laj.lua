--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Laj", 553, 561)
if not mod then return end
mod:RegisterEnableMob(17980)
mod.engageId = 1927
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34697, -- Allergic Reaction
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AllergicReaction", 34697)
	self:Log("SPELL_AURA_REMOVED", "AllergicReactionRemoved", 34697)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AllergicReaction(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 15, args.destName)
end

function mod:AllergicReactionRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
