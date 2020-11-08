
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Flameweaver Koegler", 1001, 656)
if not mod then return end
mod:RegisterEnableMob(59150)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		113682, -- Quickened Mind
		113641, -- Greater Dragon's Breath
		113364, -- Book Burner
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "QuickenedMind", 113682)
	self:Log("SPELL_CAST_START", "BreathCast", 113641)
	self:Log("SPELL_AURA_APPLIED", "BreathChannel", 113641)
	self:Log("SPELL_AURA_REMOVED", "BreathEnd", 113641)
	self:Log("SPELL_CAST_START", "BookBurner", 113364)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59150)
end

function mod:OnEngage()
	self:Bar(113641, 30, 31661) -- Dragon's Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:QuickenedMind(args)
	self:MessageOld(args.spellId, "orange", "alert", CL["onboss"]:format(args.spellName))
end

function mod:BreathCast(args)
	local breath = self:SpellName(31661)
	self:MessageOld(args.spellId, "yellow", "long", CL["casting"]:format(breath))
	self:Bar(args.spellId, 2, CL["cast"]:format(breath), args.spellId)
end

function mod:BreathChannel(args)
	self:Bar(args.spellId, 10, CL["over"]:format(self:SpellName(31661)))
end

function mod:BreathEnd(args)
	self:CDBar(args.spellId, 33, 31661) -- Dragon's Breath
	self:MessageOld(args.spellId, "green", nil, CL["over"]:format(self:SpellName(31661)))
end

function mod:BookBurner(args)
	self:Bar(args.spellId, 3, CL["cast"]:format(args.spellName))
	self:MessageOld(args.spellId, "red", "info", CL["casting"]:format(args.spellName))
end

