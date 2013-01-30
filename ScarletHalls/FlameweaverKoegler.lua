
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Flameweaver Koegler", 871, 656)
mod:RegisterEnableMob(59150)

local breath = mod:SpellName(17086)

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
	return {113682, 113641, 113364, "bosskill"}
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
	self:Bar(113641, "~"..breath, 30, 113641)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:QuickenedMind(args)
	self:Message(args.spellId, CL["onboss"]:format(args.spellName), "Urgent", args.spellId, "Alert")
end

function mod:BreathCast(args)
	self:Message(args.spellId, CL["cast"]:format(breath), "Attention", args.spellId, "Long")
	self:Bar(args.spellId, CL["cast"]:format(breath), 2, args.spellId)
end

function mod:BreathChannel(args)
	self:Bar(args.spellId, CL["over"]:format(breath), 10, args.spellId)
end

function mod:BreathEnd(args)
	self:Bar(args.spellId, "~"..breath, 33, args.spellId)
	self:Message(args.spellId, CL["over"]:format(breath), "Positive")
end

function mod:BookBurner(args)
	self:Bar(args.spellId, CL["cast"]:format(args.spellName), 3, args.spellId)
	self:Message(args.spellId, CL["cast"]:format(args.spellName), "Important", args.spellId, "Info")
end

