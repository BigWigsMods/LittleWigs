
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Grand Vizier Ertan", 657, 114)
if not mod then return end
mod:RegisterEnableMob(43878)
mod.engageId = 1043
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		86340, -- Summon Tempest
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonTempest", 86340)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonTempest(args)
	self:Bar(args.spellId, 19)
	self:MessageOld(args.spellId, "yellow")
end

