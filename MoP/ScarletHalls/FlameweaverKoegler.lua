
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Flameweaver Koegler", 871, 656)
if not mod then return end
mod:RegisterEnableMob(59150)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "You, too, shall be charred to ash!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {113682, 113641, 113364}
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
	self:Message(args.spellId, "Urgent", "Alert", CL["onboss"]:format(args.spellName))
end

function mod:BreathCast(args)
	local breath = self:SpellName(31661)
	self:Message(args.spellId, "Attention", "Long", CL["casting"]:format(breath))
	self:Bar(args.spellId, 2, CL["cast"]:format(breath), args.spellId)
end

function mod:BreathChannel(args)
	self:Bar(args.spellId, 10, CL["over"]:format(self:SpellName(31661)))
end

function mod:BreathEnd(args)
	self:CDBar(args.spellId, 33, 31661) -- Dragon's Breath
	self:Message(args.spellId, "Positive", nil, CL["over"]:format(self:SpellName(31661)))
end

function mod:BookBurner(args)
	self:Bar(args.spellId, 3, CL["cast"]:format(args.spellName))
	self:Message(args.spellId, "Important", "Info", CL["casting"]:format(args.spellName))
end

