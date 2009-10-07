-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("The Black Knight", "Trial of the Champion")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod:RegisterEnableMob(35451)
mod.defaultToggles = {"MESSAGE"}
mod.toggleOptions = {
	{67751, "BAR"}, -- Explode Ghouls
	67781, -- Desecration
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0
local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Explode", 67751)-- other possible ids :  67886, 51874, 47496, 67729,
	self:Log("SPELL_AURA_APPLIED", "Desecration", 67781, 67876)
	self:Death("Deaths", 35451)
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Explode(_, spellId, _, _, spellName)
	self:Message(67751, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(67751, spellName, 4, spellId)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 3 and bit.band(self.db.profile.bosskill, BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
		self:Win()
	end
end

function mod:Desecration(player, spellId, _, _, spellName)
	if player ~= pName then return end
	self:LocalMessage(67781, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
end	
