
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Armsmaster Harlan", 1001, 654)
if not mod then return end
mod:RegisterEnableMob(58632)

--------------------------------------------------------------------------------
-- Locals
--

local helpCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cleave = "{-5377} ({15284})" -- Dragon's Reach (Cleave)
	L.cleave_desc = -5377
	L.cleave_icon = 111217

	L.blades = -5376 -- Blades of Light
	L.blades_icon = 111216

	L.help = -5378 -- Call for Help
	L.help_icon = 27578 -- ability_warrior_battleshout / Battle Shout / icon 132333
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"cleave",
		{"blades", "FLASH"},
		"help",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Cleave", 111217)
	self:Log("SPELL_CAST_START", "BladesCastStart", 111216)
	self:Log("SPELL_AURA_APPLIED", "BladesChannel", 111216)
	self:Log("SPELL_AURA_REMOVED", "BladesEnd", 111216)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	--|TInterface\\Icons\\ability_warrior_battleshout.blp:20|tArmsmaster Harlan calls on two of his allies to join the fight!
	self:Emote("Adds", "ability_warrior_battleshout")

	self:Death("Win", 58632)
end

function mod:OnEngage()
	self:Bar("blades", 41, L["blades"], 111216)
	self:Bar("cleave", 7.1, 845) -- Cleave
	self:Bar("help", 20, L["help"], L.help_icon)
	helpCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Cleave()
	self:MessageOld("cleave", "yellow", nil, 845)
	self:Bar("cleave", 7.1, 845) -- 7.2 - 7.3
end

function mod:BladesCastStart(args)
	self:MessageOld("blades", "orange", "alert", CL["casting"]:format(args.spellName), args.spellId)
	self:Bar("blades", 6, CL["cast"]:format(args.spellName), args.spellId)
	self:Flash("blades", args.spellId)
	self:StopBar(845)
end

function mod:BladesChannel(args)
	self:MessageOld("blades", "orange", nil, CL["duration"]:format(args.spellName, "22"), args.spellId)
	self:Bar("blades", 22, args.spellId)
end

function mod:BladesEnd(args)
	self:MessageOld("blades", "yellow", nil, CL["over"]:format(args.spellName), args.spellId)
	self:Bar("blades", 33, args.spellId)
end

do
	local timers = {30, 25, 22, 20, 18, 16, 14}
	function mod:Adds()
		self:MessageOld("help", "orange", "info", L["help"], L.help_icon)
		self:Bar("help", timers[helpCount] or 13, L["help"], L.help_icon)
		helpCount = helpCount + 1
	end
end

