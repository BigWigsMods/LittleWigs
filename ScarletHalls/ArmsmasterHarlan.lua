
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
	return {"cleave", {"blades", "FLASHSHAKE"}, "help", "bosskill"}
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

function mod:Cleave(_, spellId)
	self:Message("cleave", cleave, "Attention", spellId)
	self:Bar("cleave", cleave, 7.1, spellId) -- 7.2 - 7.3
end

function mod:BladesCastStart(player, spellId, _, _, spellName)
	self:Message("blades", CL["cast"]:format(spellName), "Urgent", spellId, "Alert")
	self:Bar("blades", CL["cast"]:format(spellName), 6, spellId)
	self:FlashShake("blades")
	self:SendMessage("BigWigs_StopBar", self, cleave)
end

function mod:BladesChannel(player, spellId, _, _, spellName)
	self:Message("blades",  CL["duration"]:format(spellName, "22"), "Urgent", spellId)
	self:Bar("blades", spellName, 22, spellId)
end

function mod:BladesEnd(player, spellId, _, _, spellName)
	self:Message("blades", CL["over"]:format(spellName), "Attention", spellId)
	self:Bar("blades", spellName, 33, spellId)
end

do
	local timers = {30, 25, 22, 20, 18, 16, 14}
	function mod:Adds()
		self:Message("help", L["help"], "Urgent", 6673, "Info")
		self:Bar("help", L["help"], timers[helpCount] or 13, 6673)
		helpCount = helpCount + 1
	end
end

