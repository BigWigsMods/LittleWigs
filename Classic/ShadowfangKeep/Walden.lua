
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Walden", 33, 99)
if not mod then return end
mod:RegisterEnableMob(46963)
mod.engageId = 1073
--mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local coagulantCastEnds = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.coagulant = "%s: Move to dispel"
	L.catalyst = "%s: Crit Buff"
	L.toxin_healer_message = "%: DoT on everyone"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{93527, "CASTBAR"}, -- Ice Shards
		93505, -- Conjure Frost Mixture
		93697, -- Conjure Poisonous Mixture
		{93617, "CASTBAR"}, -- Toxic Coagulant
		{93689, "CASTBAR"}, -- Toxic Catalyst
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

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- USCS events let us distinguish between two different "Conjure Mystery Toxin" casts
end

function mod:OnEngage()
	coagulantCastEnds = 0
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:IceShards(args)
	self:MessageOld(args.spellId, "yellow", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
end

function mod:FrostMixture(args)
	self:MessageOld(args.spellId, "red", nil, CL.casting:format(args.spellName))
end

function mod:PoisonousMixture(args)
	self:MessageOld(args.spellId, "red", nil, CL.casting:format(args.spellName))
end

function mod:ToxicCoagulant(args)
	-- His channel applies a stack every 3 seconds, 3 stacks stun the target for 5 seconds
	-- let's be smart and warn the player only if they do have to move to avoid that happening
	if self:Me(args.destGUID) and args.amount == 2 then
		local remaining = coagulantCastEnds - GetTime()
		if remaining >= 3 then
			self:StackMessageOld(args.spellId, args.destName, args.amount, "orange", "warning")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId) -- Conjure Mystery Toxin
	-- spellIds ruin the mystery :(
	if spellId == 93695 then -- Toxic Coagulant
		coagulantCastEnds = GetTime() + 11
		local toxicCoagulant = self:SpellName(93617)
		self:CastBar(93617, 11)
		self:MessageOld(93617, "cyan", "info", self:Healer() and L.toxin_healer_message:format(toxicCoagulant) or L.coagulant:format(toxicCoagulant))
	elseif spellId == 93563 then -- Toxic Catalyst
		local toxicCatalyst = self:SpellName(93689)
		self:CastBar(93689, 11)
		self:MessageOld(93689, "cyan", "info", self:Healer() and L.toxin_healer_message:format(toxicCatalyst) or L.catalyst:format(toxicCatalyst))
	end
end
