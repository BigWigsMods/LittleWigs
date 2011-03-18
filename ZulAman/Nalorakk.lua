-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Nalorakk", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23576)
mod.toggleOptions = {
	"phase",
	42398,
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local lastSilence = 0

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase"] = "Phases"
L["phase_desc"] = "Warn for phase changes."
L["bear_message"] = "Bear Phase!"
L["normal_message"] = "Normal Phase!"
L["bear_trigger"] = "You call on da beast, you gonna get more dan you bargain for!"
L["normal_trigger"] = "Make way for Nalorakk!"
--@localization(locale="enUS", namespace="ZulAman/Nalorakk", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Silence", 42398)

	self:Yell("Bear", L["bear_trigger"])
	self:Yell("Normal", L["normal_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23576)
end

function mod:OnEngage()
	self:Berserk(600) -- XXX verify
	self:Bar("phase", L["bear_message"], 45, 89259)
	lastSilence = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Silence(_, spellId, _, _, spellName)
	if (GetTime() - lastSilence) > 4 then
		self:Message(42398, spellName, "Attention", spellId, "Info")
	end
	lastSilence = GetTime()
end

function mod:Bear()
	self:Message("phase", L["bear_message"], "Important", 89259)
	self:Bar("phase", L["normal_message"], 30, 89259)
end

function mod:Normal()
	self:Message("phase", L["normal_message"], "Important", 89259)
	self:Bar("phase", L["bear_message"], 45, 89259)
end

