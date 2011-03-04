--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("High Priestess Mar'li", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14510)
mod.toggleOptions = {24083, {24300, "ICON"}, "bosskill"}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_SUCCESS", "Eggs", 24083)
	self:Log("SPELL_AURA_APPLIED", "Drain", 24300)
	self:Log("SPELL_AURA_REMOVED", "DrainRemoved", 24300)
	self:Death("Win", 14510)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Eggs(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Positive", spellId)
end

function mod:Drain(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Attention", spellId)
	self:Bar(spellId, player, 7, spellId)
	self:PrimaryIcon(spellId, player)
end

function mod:DrainRemoved(player)
	self:SendMessage("BigWigs_StopBar", self, player)
	self:PrimaryIcon(24300, false)
end

