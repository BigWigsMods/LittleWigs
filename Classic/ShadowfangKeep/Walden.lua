
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Walden", 764, 99)
if not mod then return end
mod:RegisterEnableMob(46963)
mod.engageId = 1073
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

local coagulantCastEnds = 0

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
	}, {
		[93527] = "general",
		[93617] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceShards", 93527)
	self:Log("SPELL_CAST_START", "FrostMixture", 93505)
	self:Log("SPELL_CAST_START", "PoisonousMixture", 93697)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ToxicCoagulant", 93617)
end

function mod:OnEngage()
	coagulantCastEnds = 0
	if self:Heroic() then -- Conjure Mystery Toxin is heroic-only
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- USCS events let us distinguish between the two
	end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:IceShards(args)
	self:Message(args.spellId, "Attention", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
end

function mod:FrostMixture(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(args.spellName))
end

function mod:PoisonousMixture(args)
	self:Message(args.spellId, "Important", nil, CL.casting:format(args.spellName))
end

function mod:ToxicCoagulant(args)
	-- His channel applies a stack every 3 seconds, 3 stacks stun the target for 5 seconds
	-- let's be smart and warn the player only if they do have to move to avoid that happening
	if self:Me(args.destGUID) and args.amount == 2 then
		local remaining = coagulantCastEnds - GetTime()
		if remaining >= 3 then
			self:StackMessage(args.spellId, args.destName, args.amount, "Urgent", "Warning")
		end
	end
end

do
	local pattern = CL.count:gsub("%%d", "%%s") -- Chinese locales seem to use slightly different brackets, so I'll just repurpose an existing pattern
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId) -- Conjure Mystery Toxin
		-- spellIds ruin the mystery :(
		if spellId == 93695 then -- Toxic Coagulant
			local message = pattern.format(self:SpellName(-2159), self:SpellName(93617)) -- Conjure Mystery Toxin (Toxic Coagulant)
			coagulantCastEnds = GetTime() + 11
			self:CastBar(93617, 11)
			self:Message(93617, "Neutral", "Info", message)
		elseif spellId == 93563 then -- Toxic Catalyst
			local message = pattern.format(self:SpellName(-2159), self:SpellName(93689)) -- Conjure Mystery Toxin (Toxic Catalyst)
			self:CastBar(93689, 11)
			self:Message(93689, "Neutral", "Info", message)
		end
	end
end
