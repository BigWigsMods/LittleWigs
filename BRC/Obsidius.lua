-- XXX Ulic: Other suggestions?  Perhaps a timer between body shifts if it's consistant

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ascendant Lord Obsidius", "Blackrock Caverns")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39705)
mod.toggleOptions = {
	93613, -- Twilight Corruption
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Corruption", 93613)
	self:Log("SPELL_AURA_REMOVED", "CorruptionRemoved", 93613)

	self:Death("Win", 39705)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Corruption(player, spellId, _, _, spellName)
	self:Message(93613, spellName..": "..player, "Urgent", spellId)
	self:Bar(93613, player..": "..spellName, 12, spellId)
end

function mod:CorruptionRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end