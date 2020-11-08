
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Eck the Ferocious", 604, 595)
if not mod then return end
mod:RegisterEnableMob(29932)
mod.engageId = 1988

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		55817, -- Eck Residue
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EckResidue", 55817)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EckResidue(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "info")
	end
end
