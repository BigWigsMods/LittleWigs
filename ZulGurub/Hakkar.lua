--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Hakkar", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14834)
mod.toggleOptions = {24324, {24327, "ICON"}, "berserk", "bosskill"}

--------------------------------------------------------------------------------
-- Localization
--

local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Hakkar", "enUS", true)
if L then
	L.engage_trigger = "FACE THE WRATH OF THE SOULFLAYER!"
	L.flee = "Fleeing will do you no good, mortals!"

	L.drain_warning = "%d sec to Life Drain!"
	L.drain_message = "Life Drain - 90 sec to next!"
end
L = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Hakkar")
mod.locale = L

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Yell("Engage", L["engage_trigger"])
	self:Yell("Reboot", L["flee"])
	self:Log("SPELL_CAST_SUCCESS", "Siphon", 24324)
	self:Log("SPELL_AURA_APPLIED", "MC", 24327)
	self:Death("Win", 14834)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function siphonTimers(spellId)
	mod:DelayedMessage(spellId, 30, L["drain_warning"]:format(60), "Attention")
	mod:DelayedMessage(spellId, 45, L["drain_warning"]:format(45), "Attention")
	mod:DelayedMessage(spellId, 60, L["drain_warning"]:format(30), "Urgent")
	mod:DelayedMessage(spellId, 75, L["drain_warning"]:format(15), "Important")
	mod:Bar(spellId, GetSpellInfo(spellId), 90, spellId)
end

function mod:OnEngage()
	siphonTimers(24324)
	self:Berserk(600)
end

function mod:Siphon(_, spellId)
	self:Message(spellId, L["drain_message"], "Attention", spellId)
	siphonTimers(spellId)
end

function mod:MC(player, spellId)
	local mc_msg = GetSpellInfo(605) --605 = Translation of Mind Control
	self:TargetMessage(spellId, mc_msg, player, "Urgent", spellId)
	self:Bar(spellId, mc_msg..": "..player, 10, spellId)
	self:PrimaryIcon(spellId, player)
end

