-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Argent Confessor Paletress", 542)
if not mod then return end
mod.partycontent = true
mod:RegisterEnableMob(34928)
mod.toggleOptions = {
	66515, -- Shield
	66537, -- Renew
}

-------------------------------------------------------------------------------
--  Locals

local shielded = false

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = mod:GetLocale()
if L then
	L["defeat_trigger"] = "Excellent work!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ShieldGain", 66515)
	self:Log("SPELL_AURA_REMOVED", "ShieldLost", 66515)
	self:Log("SPELL_CAST_START", "Renew", 66537, 67675)

	self:Yell("Win", L["defeat_trigger"])
end

function mod:OnEngage()
	shielded = false
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ShieldGain()
	shielded = true
end

function mod:ShieldLost()
	shielded = false
end

function mod:Renew(_, spellId, _, _, spellName)
	if shielded then return end -- don't bother announcing while she is shielded
	self:Message(66537, LCL["casting"]:format(spellName), "Urgent", spellId)
end
