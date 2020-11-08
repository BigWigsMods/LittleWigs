
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Yor", 557, 536)
if not mod then return end
mod:RegisterEnableMob(22927)
-- mod.engageId = 250 --no boss frames
-- mod.respawnTime = 0 -- no idea

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		36405, -- Stomp
		38361, -- Double Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Stomp", 36405)
	self:Log("SPELL_CAST_START", "DoubleBreath", 38361)

	self:Death("Win", 22927)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Stomp(args)
	self:MessageOld(args.spellId, "red", "info")
end

function mod:DoubleBreath(args)
	self:MessageOld(args.spellId, "yellow", "long")
end
