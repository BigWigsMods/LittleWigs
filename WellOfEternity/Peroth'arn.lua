--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Peroth'arn", 816, 290)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(55085)
mod.toggleOptions = {105544, "eyes", 105442, 105493, "bosskill"}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.eyes, L.eyes_desc = EJ_GetSectionInfo(4092)
	L.eyes_icon = "inv_misc_eye_04"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Decay", 105544)
	self:Log("SPELL_AURA_APPLIED", "EasyPrey", 105493)
	self:Log("SPELL_AURA_APPLIED", "Enfeebled", 105442)

	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "Eyes")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 55085)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Decay(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Important", spellId, "Alert")
	self:Bar(spellId, CL["other"]:format(spellName, player), 10, spellId)
end

function mod:EasyPrey(player, spellId)
	local discovered = GetSpellInfo(42203) -- "Discovered", hopefully it translates as such
	self:TargetMessage(spellId, discovered, player, "Attention", spellId, "Long")
end

function mod:Enfeebled(unit, spellId, _, _, spellName)
	self:Message(spellId, CL["other"]:format(spellName, unit), "Attention", spellId, "Long")
	self:Bar(spellId, spellName, 15, spellId)
end

function mod:Eyes(_, unit, _, _, _, spellId)
	if unit == "boss1" and spellId == 105341 then
		self:DelayedMessage("eyes", 8, L["eyes"], "Positive", L["eyes_icon"], "Info")
		self:Bar("eyes", L["eyes"], 8, L["eyes_icon"])
		self:Bar(105442, GetSpellInfo(105442), 48, 105442)
	end
end

