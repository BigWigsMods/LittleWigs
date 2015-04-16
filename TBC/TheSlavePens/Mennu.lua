
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Mennu the Betrayer", 728, 570)
if not mod then return end
mod:RegisterEnableMob(17941)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		31991, -- Corrupted Nova Totem
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "CorruptedNovaTotem", 31991)

	self:Death("Win", 17941)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CorruptedNovaTotem(args)
	self:Message(args.spellId, "Attention")
end

