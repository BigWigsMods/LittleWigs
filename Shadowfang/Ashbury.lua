-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Baron Ashbury", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46962)
mod.toggleOptions = {
	93712, -- Pain and Suffering
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PnS", 93712)
	self:Log("SPELL_AURA_REMOVED", "PnSRemoved", 93712)

	self:Death("Win", 46962)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PnS(player, spellId, _, _, spellName)
	self:Message(93712, spellName..": "..player, "Urgent", spellId)
	self:Bar(93712, player..": "..spellName, 12, spellId)
end

function mod:PnSRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end