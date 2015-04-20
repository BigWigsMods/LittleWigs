
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Keristrasza", 520, 621)
if not mod then return end
mod:RegisterEnableMob(26723)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		8599, -- Enrage
		50997, -- Crystal Chains
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Enrage", 8599)
	self:Log("SPELL_AURA_APPLIED", "CrystalChains", 50997)
	self:Log("SPELL_AURA_REMOVED", "CrystalChainsRemoved", 50997)

	self:Death("Win", 26723)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrystalChains(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:CrystalChainsRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Enrage(args)
	self:Message(args.spellId, "Important", nil, "25% - ".. args.spellName) -- XXX %?
end

