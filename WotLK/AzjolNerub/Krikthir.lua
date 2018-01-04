-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Krik'thir the Gatewatcher", 533)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(28684)
mod.defaultToggles = {"MESSAGE"}
mod.toggleOptions = {
	{52592, "BAR"}, -- Curse
	28747, -- Frenzy
}

-------------------------------------------------------------------------------
--  Locals

local frenzyAnnounced = nil

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = mod:GetLocale()
if L then
	L["frenzysoon_message"] = "Frenzy Soon"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if bit.band(self.db.profile[(GetSpellInfo(28747))], BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
		self:RegisterEvent("UNIT_HEALTH")
	end
	self:Log("SPELL_AURA_APPLIED", "Curse", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "CurseRemoved", 52592, 59368)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 28747)
	self:Death("Win", 28684)
end

function mod:OnEngage()
	frenzyAnnounced = nil
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Curse(player, spellId, _, _, spellName)
	self:Message(52592, spellName..": "..player, "Attention", spellId)
	self:Bar(52592, player..": "..spellName, 10, spellId)
end

function mod:CurseRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Frenzy(boss, spellId)
	self:Message(28747, LCL["frenzied"]:format(boss), "Important", spellId)
end

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 10 and health <= 15 and not frenzyAnnounced then
		frenzyAnnounced = true
		self:Message(28747, L["frenzysoon_message"], "Important", 28747)
	elseif health > 15 and frenzyAnnounced then
		frenzyAnnounced = nil
	end
end
