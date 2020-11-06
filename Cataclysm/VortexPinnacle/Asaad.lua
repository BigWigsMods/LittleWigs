
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Asaad", 657, 116)
if not mod then return end
mod:RegisterEnableMob(43875)
mod.engageId = 1042
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		86930, -- Supremacy of the Storm
		87618, -- Static Cling
	}
end

function mod:OnBossEnable()
	-- Supremacy of the Storm is one we care about, but when he starts casting
	-- the grounding field is a good time to warn:
	self:Log("SPELL_AURA_APPLIED", "Storm", 86911)
	self:Log("SPELL_CAST_START", "StaticCling", 87618)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Storm()
	self:Bar(86930, 10)
	self:MessageOld(86930, "red", nil, CL.custom_sec:format(self:SpellName(86930), 10))
end

function mod:StaticCling(args)
	self:CDBar(args.spellId, 1.25)
	self:MessageOld(args.spellId, "yellow")
end

