-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prince Keleseth", 574, 638)
if not mod then return end
mod:RegisterEnableMob(23953)
mod:SetEncounterID(mod:Classic() and 571 or 2026)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

-------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		48400, -- Frost Tomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "FrostTomb", 48400)
	self:Log("SPELL_AURA_REMOVED", "FrostTombRemoved", 48400)
end

-------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FrostTomb(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, true)
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:FrostTombRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
