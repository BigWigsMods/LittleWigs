
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Keristrasza", 576, 621)
if not mod then return end
mod:RegisterEnableMob(26723)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		48095, -- Intense Cold
		48179, -- Crystallize (Heroic mode aoe root)
		50997, -- Crystal Chains (Normal mode single target root)
		8599, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "IntenseCold", 48095)
	self:Log("SPELL_CAST_SUCCESS", "Crystallize", 48179)
	self:Log("SPELL_AURA_APPLIED", "CrystalChains", 50997)
	self:Log("SPELL_AURA_REMOVED", "CrystalChainsRemoved", 50997)
	self:Log("SPELL_CAST_SUCCESS", "Enrage", 8599)

	self:Death("Win", 26723)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IntenseCold(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, args.amount, "blue", args.amount > 3 and "alarm")
	end
end

function mod:Crystallize(args)
	self:MessageOld(args.spellId, "orange")
end

function mod:CrystalChains(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:CrystalChainsRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Enrage(args)
	self:MessageOld(args.spellId, "red", self:Dispeller("enrage", true) and "info", CL.percent:format(25, args.spellName))
end

