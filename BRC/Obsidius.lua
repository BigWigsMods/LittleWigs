-- XXX Ulic: Other suggestions?  Perhaps a timer between body shifts if it's consistant

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ascendant Lord Obsidius", "Blackrock Caverns")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39705)
mod.toggleOptions = {
	93613, -- Twilight Corruption
	76200, -- Transformation
	76189, -- Veil
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Corruption", 76188, 93613)
	self:Log("SPELL_AURA_REMOVED", "CorruptionRemoved", 76188, 93613)
	self:Log("SPELL_AURA_APPLIED", "Change", 76200)
	self:Log("SPELL_AURA_APPLIED", "Veil", 76189)
	
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

function mod:Change(_, spellId, _, _, spellName)
	self:Message(76200, spellName, "Info", spellId)
end

function mod:Veil(player, spellId, _, _, spellName)
	self:Message(76189, spellName..": "..player, "Urgent", spellId)
	self:Bar(76189, player..": "..spellName, 4, spellId)
end
