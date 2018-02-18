
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Walden", 33, 99)
if not mod then return end
mod:RegisterEnableMob(46963)
mod.engageId = 1073

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93527, -- Ice Shards
		93505, -- Conjure Frost Mixture
		93697, -- Conjure Poisonous Mixture
		93617, -- Toxic Coagulant
		93689, -- Toxic Catalyst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceShards", 93527)
	self:Log("SPELL_CAST_START", "FrostMixture", 93505)
	self:Log("SPELL_CAST_START", "PoisonousMixture", 93697)
	self:Log("SPELL_AURA_APPLIED", "ToxicCoagulant", 93572, 93617)
	self:Log("SPELL_AURA_APPLIED", "ToxicCatalyst", 93573, 93689)
end

--[[function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end]]

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:IceShards(args)
	self:Message(args.spellId, "Attention")
end

function mod:FrostMixture(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(spellName))
end

function mod:PoisonousMixture(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(spellName))
end

do
	local prev = 0
	function mod:ToxicCoagulant(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 5 then
				prev = t
				self:Message(93617, "Urgent", "Alert")
			end
		end
	end
end

function mod:ToxicCatalyst(args)
	if self:Me(args.destGUID) then
		self:Message(93689, "Urgent", "Alert")
	end
end
