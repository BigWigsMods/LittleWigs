
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Eck the Ferocious", 530, 595)
if not mod then return end
mod:RegisterEnableMob(29932)

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

	self:Death("Win", 29932)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EckResidue(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Info")
	end
end

