
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

function mod:QuickenedMind(player, spellId, _, _, spellName)
	self:Message(spellId, CL["onboss"]:format(spellName), "Urgent", spellId, "Alert")
end

function mod:BreathCast(_, spellId)
	self:Message(spellId, CL["cast"]:format(breath), "Attention", spellId, "Long")
	self:Bar(spellId, CL["cast"]:format(breath), 2, spellId)
end

function mod:BreathChannel(_, spellId)
	self:Bar(spellId, CL["over"]:format(breath), 10, spellId)
end

function mod:BreathEnd(_, spellId)
	self:Bar(spellId, "~"..breath, 33, spellId)
	self:Message(spellId, CL["over"]:format(breath), "Positive")
end

function mod:BookBurner(_, spellId, _, _, spellName)
	self:Bar(spellId, CL["cast"]:format(spellName), 3, spellId)
	self:Message(spellId, CL["cast"]:format(spellName), "Important", spellId, "Info")
end

