
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Armsmaster Harlan", 871, 654)
mod:RegisterEnableMob(58632)

local cleave = mod:SpellName(845)
local helpCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Ah-hah! Another chance to test my might."

	L.cleave = EJ_GetSectionInfo(5377) .. " (".. cleave ..")"
	L.cleave_desc = select(2, EJ_GetSectionInfo(5377))
	L.cleave_icon = 111217

	L.blades, L.blades_desc = EJ_GetSectionInfo(5376)
	L.blades_icon = 111216

	L.help, L.help_desc = EJ_GetSectionInfo(5378)
	L.help_icon = 6673
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"cleave", {"blades", "FLASH"}, "help", "bosskill"}
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
	self:Bar("blades", L["blades"], 41, 111216)
	self:Bar("cleave", cleave, 7.1, 111217)
	self:Bar("help", L["help"], 20, 6673)
	helpCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Cleave(args)
	self:Message("cleave", cleave, "Attention", args.spellId)
	self:Bar("cleave", cleave, 7.1, args.spellId) -- 7.2 - 7.3
end

function mod:BladesCastStart(args)
	self:Message("blades", CL["cast"]:format(args.spellName), "Urgent", args.spellId, "Alert")
	self:Bar("blades", CL["cast"]:format(args.spellName), 6, args.spellId)
	self:Flash("blades")
	self:StopBar(cleave)
end

function mod:BladesChannel(args)
	self:Message("blades",  CL["duration"]:format(args.spellName, "22"), "Urgent", args.spellId)
	self:Bar("blades", args.spellName, 22, args.spellId)
end

function mod:BladesEnd(args)
	self:Message("blades", CL["over"]:format(args.spellName), "Attention", args.spellId)
	self:Bar("blades", args.spellName, 33, args.spellId)
end

do
	local timers = {30, 25, 22, 20, 18, 16, 14}
	function mod:Adds()
		self:Message("help", L["help"], "Urgent", 6673, "Info")
		self:Bar("help", L["help"], timers[helpCount] or 13, 6673)
		helpCount = helpCount + 1
	end
end

