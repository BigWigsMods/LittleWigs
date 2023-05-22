
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Selin Fireheart", 585, 530)
if not mod then return end
mod:RegisterEnableMob(24723)
mod.engageId = 1897
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{44320, "CASTBAR"}, -- Mana Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ManaRage", 44320)
	self:Log("SPELL_AURA_REMOVED", "ManaRageEnd", 44320)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ManaRage(args)
	self:MessageOld(args.spellId, "red", "info", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 10)
end

function mod:ManaRageEnd(args)
	self:StopBar(CL.cast:format(args.spellName))
end
