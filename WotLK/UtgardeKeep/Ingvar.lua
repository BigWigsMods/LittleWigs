-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ingvar the Plunderer", 523)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(23954)
mod.toggleOptions = {
	42723, -- Smash
	42730, -- Roar
	42708, -- Woe Strike
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Smash", 42723, 42669, 59706)
	self:Log("SPELL_CAST_START", "Roar", 42708, 42729, 59708, 59734)
	self:Log("SPELL_AURA_APPLIED", "Woe", 42730, 59735)
	self:Death("Deaths", 23954)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Smash(_, spellID, _, _, spellName)
	self:Message(42723, LCL["casting"]:format(spellName), "Urgent", spellID)
	self:Bar(42723, spellName, 3, spellID)
end

function mod:Roar(_, spellID, _, _, spellName)
	self:Message(42708, LCL["casting"]:format(spellName), "Urgent", spellID)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 2 then
		self:Win()
	end
end

function mod:Woe(player, spellId, _, _, spellName)
	self:Message(42730, spellName..": "..player, "Urgent", spellId)
	self:Bar(42730, player..": "..spellName, 10, spellId)
end
