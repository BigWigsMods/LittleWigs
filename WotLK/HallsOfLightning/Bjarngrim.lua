
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("General Bjarngrim", 602, 597)
if not mod then return end
mod:RegisterEnableMob(28586)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		16856, -- Mortal Strike
		41107, -- Berserker Aura
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalStrike", 16856)
	self:Log("SPELL_AURA_APPLIED", "BerserkerAura", 41107)
	self:Log("SPELL_AURA_REMOVED", "BerserkerAuraRemoved", 41107)

	self:Death("Win", 28586)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MortalStrike(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 5, args.destName)
end

function mod:BerserkerAura(args)
	if self:MobId(args.destGUID) == 28586 then -- Boss only
		self:MessageOld(args.spellId, "orange")
	end
end

function mod:BerserkerAuraRemoved(args)
	if self:MobId(args.destGUID) == 28586 then -- Boss only
		self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
	end
end

