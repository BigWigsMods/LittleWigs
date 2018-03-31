
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Roltall", 1175, 887)
if not mod then return end
mod:RegisterEnableMob(75786)
mod.engageId = 1652
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153247, -- Fiery Boulder
		152940, -- Heat Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FieryBoulder", 153247)
	self:Log("SPELL_CAST_START", "HeatWaveInc", 152940)
	self:Log("SPELL_CAST_SUCCESS", "HeatWaveBegin", 152940)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FieryBoulder(args)
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:HeatWaveInc(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
end

function mod:HeatWaveBegin(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end
