-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Nalorakk", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23576)
mod.toggleOptions = {
	"forms",
	42398, -- Deafening
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local lastSilence = 0
local bear = GetSpellInfo(7090)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["forms"] = "Forms"
	L["forms_desc"] = "Warn for form changes."
	L["troll_message"] = "Troll Form"
	L["troll_trigger"] = "Make way for da Nalorakk!"
	L["bear_trigger"] = "You call on da beast"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Silence", 42398)
	self:Log("UNIT_SPELLCAST_SUCCEEDED", "Bear", 42377)

	self:Yell("Bear", L["bear_trigger"])
	self:Yell("Troll", L["troll_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23576)
end

function mod:OnEngage()
	self:Bar("forms", bear, 30, 42594)
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
	self:Message("forms", bear, "Important", 42594)
	self:Bar("forms", L["troll_message"], 30, 89259)
end

function mod:Troll()
	self:Message("forms", L["troll_message"], "Important", 89259)
	self:Bar("forms", bear, 30, 42594)
end

