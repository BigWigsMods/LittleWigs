-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Priestess Delrissa", 798, 532)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(24553,24554,24555,24556,24557,24558,24559,24560,24561)
mod.toggleOptions = {
	46192, -- Renew
	46193, -- Power Word: Shield
	27621, -- Apoko: Windfury Totem
	44178, -- Yazzai: Blizzard
	13323, -- Yazzai: Polymorph
	44141, -- Ellrys: Seed of Corruption
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PriShield", 46193, 44175, 44291)
	self:Log("SPELL_AURA_APPLIED", "PriRenew", 44174, 46192)
	self:Log("SPELL_CAST_SUCCESS", "ApokoWF", 27621)
	self:Log("SPELL_AURA_APPLIED", "EllrysSoC", 44141)
	self:Log("SPELL_AURA_APPLIED", "YazzaiPoly", 13323)
	self:Log("SPELL_CAST_SUCCESS", "YazzaiBliz", 44178, 46195)
	self:Log("SPELL_AURA_REMOVED", "Removed", 13323, 44141, 44174, 46192)
	self:Death("Deaths", 24553, 24554, 24555, 24556, 24557, 24558, 24559, 24560, 24561)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PriShield(player, spellId, _, _, spellName)
	self:Message(46193, spellName.." - "..player, "Attention", spellId)
end

function mod:PriRenew(player, spellId, _, _, spellName)
	self:Message(46192, spellName..": "..player, "Attention", spellId)
	self:Bar(46192, player..": "..spellName, 15, spellId)
end

function mod:ApokoWF(_, spellId, _, _, spellName)
	self:Message(27621, spellName, "Attention", spellId)
end

function mod:EllrysSoC(player, spellId, _, _, spellName)
	self:Message(44141, spellName..": "..player, "Attention", spellId)
	self:Bar(44141, player..": "..spellName, 18, spellId)
	self:PrimaryIcon(44141, player)
end

function mod:YazzaiPoly(player, spellId, _, _, spellName)
	self:Message(13323, spellName..": "..player, "Attention", spellId)
	self:Bar(13323, player..": "..spellName, 8, spellId)
end

function mod:YazzaiBliz(spellId, _, _, _, spellName)
	self:Message(44178, LCL["casting"]:format(spellName), "Attention", spellId)
end

function mod:Remove(player, spellId, _, _, spellName)
	if spellId == 44141 then self:PrimaryIcon(44141, false) end
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	end
end
