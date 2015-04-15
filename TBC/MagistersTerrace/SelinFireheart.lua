-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Selin Fireheart", 798, 530)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(24723)
mod.toggleOptions = {
	44320, -- Mana Rage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Channel", 44320)
	self:Log("SPELL_AURA_REMOVED", "ChannelEnd", 44320)
	self:Death("Win", 24723)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Channel(_, spellId, _, _, spellname)
	self:Message(44320, spellName "Important", spellId)
	self:Bar(44320, spellName, 10, spellId)
end

function mod:ChannelEnd(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end
