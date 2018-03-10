-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Xevozz", 536)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod:RegisterEnableMob(29266, 32231)
mod.toggleOptions = {
	54102, -- Summon Sphere
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["sphere_message"] = "Summoning Ethereal Sphere"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Sphere", 54102, 54137, 54138, 61337, 61338)
	self:Death("Win", 29266, 32231)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Sphere(_, spellId)
	self:Message(54102, L["sphere_message"], "Important", spellId)
end
