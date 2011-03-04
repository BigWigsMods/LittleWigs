--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Jin'do the Hexxer", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(11380)
mod.toggleOptions = {24306, 24262, 24309, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Delusions", 24306)
	self:Log("SPELL_AURA_REMOVED", "DelusionsRemoved", 24306)
	self:Log("SPELL_AURA_SUCCESS", "BrainWash", 24262)
	self:Log("SPELL_AURA_SUCCESS", "Healing", 24309)
	self:Death("Win", 11380)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Delusions(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Attention", spellId)
	self:Bar(spellId, player, 20, spellId)
end

function mod:DelusionsRemoved(player)
	self:SendMessage("BigWigs_StopBar", self, player)
end

function mod:BrainWash(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId)
end

function mod:Healing(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Positive", spellId)
end

