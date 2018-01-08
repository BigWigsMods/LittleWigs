-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Eadric the Pure", 542)
if not mod then return end
mod.partycontent = true
mod:RegisterEnableMob(35119)
mod.toggleOptions = {
	66935, -- Radiance
}

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = mod:GetLocale()
if L then
	L["defeat_trigger"] = "I yield! I submit. Excellent work. May I run away now?"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "radiance", 66935, 66862, 67681)

	self:Yell("Win", L["defeat_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:radiance(_, spellId, _, _, spellName)
	self:Message(66935, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(66935, spellName, 3, spellId)
end
