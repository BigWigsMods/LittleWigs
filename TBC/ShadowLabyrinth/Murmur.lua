-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Murmer", 724, 547)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18708)
mod.toggleOptions = {
	33923, -- Sonic Boom
	{33711, "ICON", "WHISPER"}, -- Murmur's Touch
}

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Touch", 33711, 38794)
	self:Log("SPELL_CAST_START", "Boom", 33923, 38796)
	self:Death("Win", 18708)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Touch(player, spellId, _, _, spellName)
	self:TargetMessage(33711, spellName, player, "Personal", spellId, "Alarm")
	self:Whisper(33711, player, BCL["you"]:format(spellName))
	self:Bar(33711, player..": "..spellName, 13, spellId, "Red")
	self:PrimaryIcon(33711, player)
end

function mod:Boom(_, _, _, _, spellName)
	self:Message(33923, LCL["casting"]:format(spellName), "Important", 33923)
	self:Bar(33923, spellName, 5, 33923, "Red")
end
